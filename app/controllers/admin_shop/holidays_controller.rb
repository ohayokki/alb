class AdminShop::HolidaysController < ApplicationController
  def edit
    @shop = shop_obj
  end

  def index
    @shop = shop_obj
    @holiday = @shop.holidays.build
  end
end
