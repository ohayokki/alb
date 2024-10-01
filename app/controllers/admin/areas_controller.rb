class Admin::AreasController < Admin::AdminController 

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    # Districtの選択肢または新規追加の処理
    if params[:area][:new_district_name].present?
      # 新しいDistrictを作成
      district = District.find_or_create_by(name: params[:area][:new_district_name], prefecture_id: params[:area][:prefecture_id])
      @area.district = district
    end
    if @area.save
      respond_to do |format|
        flash[:success] = "エリアを追加しました。"
        format.html { redirect_to admin_shops_path }
        format.json { render json: @area, status: :created }
      end
    else
      respond_to do |format|
        flash.now[:danger] = "エリア追加に失敗しました。"
        format.html { render :new, status: :unprocessable_entity }
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
    params.require(:area).permit(:name, :prefecture_id, :district_id, :new_district_name)
  end
end
