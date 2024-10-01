class AdminShop::StaffsController < AdminShop::AdminController
  before_action :set_staff, only: [:edit, :update, :destroy]
  def index
    @staffs = @shop.staffs.order("created_at")
    @staff = @shop.staffs.build
  end

  def create
    @staff = @shop.staffs.build(staff_params)
    if @staff.save
      flash[:success] = "スタッフ登録しました。"
      redirect_to admin_shop_staffs_url
    else
      @staffs = @shop.staffs.order("created_at")
      flash.now[:danger] = "スタッフ登録に失敗しました。"
      render "admin_shop/staffs/index", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      flash[:success] = "スタッフの編集を行いました"
      redirect_to  admin_shop_staffs_url
    else
      flash.now[:danger] = "スタッフ編集に失敗しました。"
      render "admin_shop/staffs/edit", status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def set_staff
    @staff = @shop.staffs.find(params[:id])
  end
  def staff_params
    params.require(:staff).permit(:name, :blood_type, :birthday, :height, :alcohol, :message,
                         :image, :remove_image, :image_cache, :hobby, :role, :service_style, :qualifications)
  end
end
