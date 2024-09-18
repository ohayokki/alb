class DistrictsController < ApplicationController
  def index
    @district = District.find_by(name: params[:id])
    @title = @district.display_name 
    @genres = Genre.joins(:shops).where(shops: { district_id: @district.id, status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct

    @shops = @district.shops.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre)
    @areas = @district.areas.joins(:shops).where(shops: { status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct

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

  # 都道府県選択後の地域選択フォーム表示
  def by_prefecture
    @districts = District.where(prefecture_id: params[:prefecture_id])
    render json: @districts.map { |district| { id: district.id, name: district.display_name } }
  end
end
