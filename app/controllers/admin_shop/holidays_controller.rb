class AdminShop::HolidaysController < ApplicationController

  def index
    @shop = shop_obj
    @holiday = @shop.holidays.build
  end

  def create
    @shop = shop_obj
    @holiday = @shop.holidays.new(holiday_params)
    if @holiday.save
      flash[:success] = "特別な日が登録されました。"
      redirect_to admin_shop_admin_index_url
    else
      flash.now[:danger] = "特別な日の登録に失敗しました。"
      render "admin_shop/holidays/index", status: :unprocessable_entity
    end
  end

  def edit
    @shop = shop_obj
    @holiday = @shop.holidays.find(params[:id])
  end

  def update
    @shop = shop_obj
    @holiday = @shop.holidays.find(params[:id])
    if @holiday.update(holiday_params)
      flash[:success] = "特別な日が更新されました。"
      redirect_to admin_shop_shop_path(@shop)
    else
      flash.now[:danger] = "特別な日の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop = shop_obj
    @holiday = @shop.holidays.find(params[:id])
    @holiday.destroy
    flash[:success] = "特別な日が削除されました。"
    redirect_to admin_shop_shop_path(@shop)
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def holiday_params
    params.require(:holiday).permit(:date, :status)
  end

  
end
