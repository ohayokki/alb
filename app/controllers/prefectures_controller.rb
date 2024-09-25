class PrefecturesController < ApplicationController
  def index
    @prefecture = Prefecture.includes(:districts).find_by(name: params[:id])
    @title = @prefecture.display_name
    near_shop(@prefecture.shops)
    @genres = Genre.joins(:shops)
      .where(shops: { id: @prefecture.shops.select(:id) })
      .distinct
  end
end
