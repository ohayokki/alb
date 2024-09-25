class AreasController < ApplicationController
  def show
    @area = Area.find(params[:id])
    @title = @area.name
    @areas = Area.joins(:shops).where(shops: { status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).where.not(id: @area.id).distinct
    @genres = Genre.joins(:shops).where(shops: { area_id: @area.id, status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    near_shop(@area.shops)
  end
end
