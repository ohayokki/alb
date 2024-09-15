class PrefecturesController < ApplicationController
  def index
    @prefecture = Prefecture.includes(:districts).find_by(name: params[:id])
    @shops = @prefecture.shops.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre)
    @genres = Genre.joins(:shops).where(shops: { id: @shops.select(:id) }).distinct

    if params[:latitude].present? && params[:longitude].present?
      @latitude = params[:latitude].to_f
      @longitude = params[:longitude].to_f

      # 距離を計算
      @shops = @shops.map do |shop|
        distance = Geocoder::Calculations.distance_between([@latitude, @longitude], [shop.latitude, shop.longitude])
        shop.distance = distance # Distanceを仮想属性として追加
        shop
      end
      @shops.sort_by!(&:distance) # 距離でソート
    end
  end
end
