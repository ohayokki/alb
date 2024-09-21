class AdminShop::LabelsController < AdminShop::AdminController
  def create
    @label = Label.new(label_params)

    if @label.save
      flash[:success] = "Tagを作成しました。"
      redirect_back(fallback_location: root_url)
    else
      @labels = Label.all
      flash.now[:danger] = "Tag作成に失敗しました。"
      render "admin_shop/admin/labels", status: :unprocessable_entity
    end
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end
end
