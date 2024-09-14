class Admin::AreasController < ApplicationController
  def create
    @area = Area.new(area_params)
    if @area.save
      respond_to do |format|
        format.html { redirect_to new_admin_shop_path, notice: 'エリアが追加されました。' }
        format.json { render json: @area, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  def districts
    @districts = District.where(prefecture_id: params[:prefecture_id])
    render json: @districts
  end

  # 地域登録用
  def by_district
    @areas = Area.where(district_id: params[:district_id])
    render json: @areas.map { |area| { id: area.id, name: area.display_name } }
  end


  private

  def area_params
    params.require(:area).permit(:name, :prefecture_id, :district_id)
  end
end
