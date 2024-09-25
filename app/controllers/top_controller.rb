class TopController < ApplicationController
  def index
    @title = "全国"
    if params[:search].present?
      @shops = Shop.search_by_term(params[:search])
    else
      @new_shops = Shop.includes(:area, :genre).order("created_at desc").where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).limit(25)
      if session[:latitude].present? && session[:longitude].present?
        @shops = Shop.near([session[:latitude], session[:longitude]], 50, units: :km) # 50km以内で検索
          .where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
          .includes(:area, :genre)
          .limit(20)
        # サーバーサイドで距離を計算
        @shops = @shops.map do |shop|
          distance = Geocoder::Calculations.distance_between([session[:latitude], session[:longitude]], [shop.latitude, shop.longitude])
          shop.distance = distance # Distanceを仮想属性として追加
          shop
        end
        @shops.sort_by!(&:distance) # 距離でソート
      elsif params[:latitude].present? && params[:longitude].present?
        @latitude = params[:latitude].to_f
        @longitude = params[:longitude].to_f
        @shops = Shop.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre).limit(20)
        @shops = Shop.near([@latitude, @longitude ], 50, units: :km) # 50km以内で検索
          .where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
          .includes(:area, :genre)
          .limit(20)
      
        # サーバーサイドで距離を計算
        @shops = @shops.map do |shop|
          distance = Geocoder::Calculations.distance_between([@latitude, @longitude], [shop.latitude, shop.longitude])
          shop.distance = distance # Distanceを仮想属性として追加
          shop
        end
        @shops.sort_by!(&:distance) # 距離でソート
      end
    end
  end

  def privacy_policy
  end

  def terms
  end
  def save_location
    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    head :ok
  end
end
