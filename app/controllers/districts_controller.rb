class DistrictsController < ApplicationController
  def index
    @district = District.find_by(name: params[:id])
    @title = @district.display_name 
    @genres = Genre.joins(:shops).where(shops: { district_id: @district.id, status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    @areas = @district.areas.joins(:shops).where(shops: { status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    @near_shops = near_shop(@district.shops)
    @shops = @district.shops.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre, :staffs)
          .order(Arel.sql("CASE 
          WHEN status = 4 THEN 1  -- 有料掲載
          WHEN status = 3 THEN 2  -- お試し有料掲載
          WHEN status = 2 THEN 3  -- 無料掲載
        END"), "created_at DESC")
      .limit(25)
    @notices = @district.notices.order("date desc").includes(:shop)
  end

  # 都道府県選択後の地域選択フォーム表示
  def by_prefecture
    @districts = District.where(prefecture_id: params[:prefecture_id])
    render json: @districts.map { |district| { id: district.id, name: district.display_name } }
  end
end
