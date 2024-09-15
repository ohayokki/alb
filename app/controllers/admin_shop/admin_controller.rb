class AdminShop::AdminController < ApplicationController
  before_action :shop_signed_in?

  def index
    @shop = shop_obj
    # カレンダーで表示されている月の開始日と終了日を取得
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @holidays = @shop.holidays_for_month(start_date.year, start_date.month)
  end

  # 店舗情報編集
  def shopedit
    @shop = Shop.find(session[:shop_id])
  end

  def update
  end
end
