# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController

  require 'net/http'
  require 'json'
  require 'uri'
  require 'securerandom'

  def login
  end

  def line_login
    if Rails.env.development?
      session[:user_id] = 1
      return  redirect_to user_page_path, notice: 'ログインしました!'
    end
    # ログインセッションごとにWebアプリでランダム生成CSRF用
    session[:state] = SecureRandom.urlsafe_base64
    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    client_id = ENV['LINE_CHANNEL_ID']
    redirect_uri = ENV['LINE_REDIRECT_URI']
    state = session[:state]
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限
    authorization_url = "#{base_authorization_url}?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"

    redirect_to authorization_url, allow_other_host: true
  end


  def create
    # CSRF対策のトークンが一致する場合のみ、ログイン処理を続ける
    # ステートが一致しない場合はエラー処理
    state = params[:state]
    return redirect_to root_path, alert: '不正なアクセスです' if state != session[:state]
  
    code = params[:code]
    
    # トークン取得リクエスト
    uri = URI('https://api.line.me/oauth2/v2.1/token')
    res = Net::HTTP.post_form(uri, {
      'grant_type' => 'authorization_code',
      'code' => code,
      'redirect_uri' => ENV['LINE_REDIRECT_URI'],
      'client_id' => ENV['LINE_CHANNEL_ID'],
      'client_secret' => ENV['LINE_CHANNEL_SECRET']
    })
    
    token_info = JSON.parse(res.body)
    Rails.logger.info "Token info: #{token_info.inspect}"  # トークン情報のログ出力
    access_token = token_info['access_token']
    
    # プロフィール情報取得リクエスト
    uri = URI('https://api.line.me/v2/profile')
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{access_token}"
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.request(req)
    rescue TypeError => e
      Rails.logger.error "TypeError: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
    end
    
    user_info = JSON.parse(res.body)
    Rails.logger.info "User info: #{user_info.inspect}"  # ユーザー情報のログ出力
    
    @user = User.find_or_initialize_by(line_uid: user_info['userId'])
    @user.name = user_info['displayName']
    @user.image_url = user_info['pictureUrl']
    @user.save
    
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_page_path, notice: 'ログインしました!'
    else
      flash[:danger] = "ログインに失敗しました。"
      redirect_to root_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'ログアウト成功'
  end

  private

end
