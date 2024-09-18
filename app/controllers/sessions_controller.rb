# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController

  require 'json'
  #require 'typhoeus'
  require 'securerandom'

  def login
  end

  def line_login
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
    if params[:state] == session[:state]

      line_user_id = ENV['LINE_REDIRECT_URI']
      user = User.find_or_initialize_by(line_user_id: line_user_id)

      if user.save
        session[:user_id] = user.id
        redirect_to root_path, notice: 'ログインしました'
      else
        redirect_to login_path, notice: 'ログインに失敗しました'
      end

    else
      redirect_to login_path, notice: '不正なアクセスです'
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'ログアウト成功'
  end

  private
  def get_line_user_id_token(code)

    # ユーザーのアクセストークン（IDトークン）を取得する
    # https://developers.line.biz/ja/reference/line-login/#issue-access-token

    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_uri = line_login_api_callback_url

    options = {
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri,
        client_id: 'LINEログインチャネルのチャネルID', # 本番環境では環境変数などに保管
        client_secret: 'LINEログインチャネルのチャネルシークレット' # 本番環境では環境変数などに保管
      }
    }
    response = Typhoeus::Request.post(url, options)

    if response.code == 200
      JSON.parse(response.body)['id_token'] # ユーザー情報を含むJSONウェブトークン（JWT）
    else
      nil
    end
  end

end
