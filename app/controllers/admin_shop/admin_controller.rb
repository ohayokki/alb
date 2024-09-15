class AdminShop::AdminController < ApplicationController
  before_action :shop_signed_in?

  def index
  end

  # 店舗情報編集
  def shopedit
    @shop = Shop.find(session[:shop_id])
  end

  def update
  end
end
