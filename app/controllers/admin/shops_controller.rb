class Admin::ShopsController < ApplicationController
  before_action :set_shop, only: %i[edit show update status_change]

  def index
    @shops = Shop.includes(:genre, :area).order(status: :asc)
  end

  def new
    @shop = Shop.new
    @area = Area.new
  end

  def show
    @districts = District.where(prefecture_id: @shop.prefecture_id)
    @areas = Area.where(district_id: @shop.district_id)
  end

  def edit
  end

  def update
    @shop.assign_attributes(shop_params)
    unless @shop.area_id.present?
      flash[:danger] = "地域を登録してください。"
      return redirect_to admin_shops_path
    end
    if @shop.valid?(:update_shop) && @shop.save
      redirect_to admin_shops_url, notice: 'ショップ情報が更新されました。'
    else
      render "admin/shops/show"
    end
  end

  def status_change
    @shop.update!(status: params[:status])
    redirect_to admin_shops_url
  end

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(
      :name,
      :title,
      :budget,
      :reservation,
      :wifi,
      :alcohol,
      :smoking,
      :english,
      :korean, :tel,
      :introduction,
      :access, :latitude, :longitude, :googlemap, :shop_logo, :card_company,
      :hours, :holiday,
      :card_payment,
      :mobile_payment,
      :website,
      :notes,
      :coupon,
      :address,
      :area_id, :district_id, :prefecture_id,
      :costume_id,
      :genre_id,
      tag_ids: []
    ).tap do |whitelisted|
      if params[:shop][:area_id].present?
        area = Area.find(params[:shop][:area_id])
        whitelisted[:prefecture_id] = area.prefecture_id
        whitelisted[:district_id] = area.district_id
      end
    end
  end
end
