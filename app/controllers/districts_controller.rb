class DistrictsController < ApplicationController
  def index
    @district = District.find_by(name: params[:id])
    @title = @district.display_name 
    @genres = Genre.joins(:shops).where(shops: { district_id: @district.id, status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    @areas = @district.areas.joins(:shops).where(shops: { status: ["無料掲載", "有料掲載", "お試し有料掲載"] }).distinct
    near_shop(@district.shops)
  end

  # 都道府県選択後の地域選択フォーム表示
  def by_prefecture
    @districts = District.where(prefecture_id: params[:prefecture_id])
    render json: @districts.map { |district| { id: district.id, name: district.display_name } }
  end
end
