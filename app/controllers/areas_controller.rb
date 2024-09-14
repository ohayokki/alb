class AreasController < ApplicationController
  def show
    @genres = Genre.all
    @area = Area.find(params[:id])
    @areas = Area.all - [@area] # 現在のエリアを除外したリスト
    @shops = @area.shops.where(status: ["無料掲載", "有料掲載"]).includes(:genre)

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
