class AdminShop::AdminController < ApplicationController
  before_action :shop_signed_in?, :set_shop
  layout "admin_shop"

  def index
    @shop = shop_obj
    # カレンダーで表示されている月の開始日と終了日を取得
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @holidays = @shop.holidays_for_month(start_date)
    @notices = Notice.where(shop: @shop)
    @notices_by_date = @notices.group_by(&:date)
  end

  # 店舗情報編集
  def shopedit
    @shop = Shop.find(session[:shop_id])
  end

  def coupon
  end

  def images
  end

  private
  def shop_signed_in?
    unless shop_logged_in?
      redirect_to root_url
    end
  end

  def set_shop
    @shop = shop_obj
  end
end
