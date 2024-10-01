class AreasController < ApplicationController
  def show
    @area = Area.find(params[:id])
    @title = @area.name
    @areas = Area.joins(:shops).where(shops: { status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).where.not(id: @area.id).distinct
    @genres = Genre.joins(:shops).where(shops: { area_id: @area.id, status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    @near_shops = near_shop(@area.shops)
    @shops = @area.shops.where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).includes(:area, :genre, :staffs)
          .order(Arel.sql("CASE 
          WHEN status = 4 THEN 1  -- 有料掲載
          WHEN status = 3 THEN 2  -- お試し有料掲載
          WHEN status = 2 THEN 3  -- 無料掲載
        END"), "created_at DESC")
      .limit(25)
    @notices = @area.notices.order("date desc").includes(:shop)
  end
end
