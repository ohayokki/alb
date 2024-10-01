class PrefecturesController < ApplicationController
  def index
    @prefecture = Prefecture.includes(:districts).find_by(name: params[:id])
    @districts = @prefecture.districts
    @title = @prefecture.display_name
    @shops = @prefecture.shops.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre, :staffs)
          .order(Arel.sql("CASE 
          WHEN status = 4 THEN 1  -- 有料掲載
          WHEN status = 3 THEN 2  -- お試し有料掲載
          WHEN status = 2 THEN 3  -- 無料掲載
        END"), "created_at DESC")
      .limit(25)
    @near_shops = near_shop(@prefecture.shops)
    @genres = Genre.joins(:shops)
      .where(shops: { id: @prefecture.shops.select(:id) })
      .distinct
    @notices = @prefecture.notices.order("date desc").includes(:shop)
  end
end
