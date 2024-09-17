class AdminShop::HolidaysController < AdminShop::AdminController
  def index
    @holiday = @shop.holidays.build
  end

  def create
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
    @holiday = @shop.holidays.find(params[:id])
  end

  def update
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
    @holiday = @shop.holidays.find(params[:id])
    @holiday.destroy
    flash[:success] = "特別な日が削除されました。"
    redirect_to admin_shop_shop_path(@shop)
  end

  private
  def holiday_params
    params.require(:holiday).permit(:date, :status)
  end
end
