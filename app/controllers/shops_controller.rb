class ShopsController < ApplicationController
  before_action :set_shop, only: [:show]
  def create
    @shop = Shop.new(shop_params)
    @shop.status = "掲載依頼"
    if @shop.save
      redirect_to shop_request_confirm_path
    else
      flash.now[:danger] = 'ショップの作成に失敗しました。'
      render "contacts/post_request", status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(
      :manager_name, :name, :address, :genre_id, :access, :area_description, :hours, :budget,
      :title, :introduction, :tel,
      :shop_logo,

      :reservation,
      :wifi,
      :alcohol,
      :smoking,
      :english,
      :korean,
      :card_payment,
      :mobile_payment,
      :website,
      :notes,
      :coupon,
      :costume_id,
      tag_ids: []
    )
  end
end
