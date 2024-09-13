class TopController < ApplicationController
  def index
    @new_shops = Shop.all.order("created_at desc").where(status: ["無料掲載", "有料掲載"]).limit(25)
    if params[:latitude].present? && params[:longitude].present?
      @latitude = params[:latitude].to_f
      @longitude = params[:longitude].to_f
      @shops = Shop.where(status: ["無料掲載", "有料掲載"]).limit(20)

      # サーバーサイドで距離を計算
      @shops = @shops.map do |shop|
        distance = Geocoder::Calculations.distance_between([@latitude, @longitude], [shop.latitude, shop.longitude])
        shop.distance = distance # Distanceを仮想属性として追加
        shop
      end
      @shops.sort_by!(&:distance) # 距離でソート
    end
  end

  def privacy_policy
  end

  def terms
  end
end
