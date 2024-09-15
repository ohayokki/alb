class AdminShop::ShopsController < ApplicationController
  before_action :shop_signed_in?

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = "店舗情報修正しました。"
      redirect_to admin_shop_admin_index_url
    else
      flash.now[:danger] = "店舗情報修正に失敗しました。"
      render "admin_shop/admin/shopedit", status: :unprocessable_entity
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_logo, :tel, :address, :hours, :holiday, :budget, :access,
     :title, :introduction, :website, :reservation, :wifi, :alcohol, :smoking, :english, :korean, :card_payment, :mobile_payment,
     :image1, :image2, :image3, :image4, :image5, weekly_holidays: [])
  end
end
