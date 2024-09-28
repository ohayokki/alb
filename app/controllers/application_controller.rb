class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale
  include SessionsHelper

  private
  def set_user
    current_user = User.find(1)
    session[:user_id] = current_user.id
  end
  
  def near_shop(scope = nil)
    if session[:latitude].present? && session[:longitude].present?
      @latitude = session[:latitude]
      @longitude = session[:longitude]
    elsif params[:latitude].present? && params[:longitude].present?
      @latitude = params[:latitude].to_f
      @longitude = params[:longitude].to_f
    end
  
    scope ||= Shop.all

    if @latitude.present? && @longitude.present?
      @shops = scope.near([@latitude, @longitude], 50, units: :km) # 緯度・経度を配列で指定
                    .where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
                    .includes(:area, :genre)
                    .limit(20)
      
      # サーバーサイドで距離を計算
      @shops = @shops.map do |shop|
        distance = Geocoder::Calculations.distance_between([@latitude, @longitude], [shop.latitude, shop.longitude])
        shop.distance = distance # Distanceを仮想属性として追加
        shop
      end
      
      # 距離でソート
      @shops.sort_by!(&:distance)
      
      return @shops
    else
      @shops = scope.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_shops_path
    else
      root_path # その他のユーザーの場合のリダイレクト先
    end
  end

  # 登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_shops_path
    else
      root_path # その他のユーザーの場合のリダイレクト先
    end
  end
end
