class AdminShop::NoticesController < AdminShop::AdminController
  def index
    @notice = @shop.notices.build
    @notices = @shop.notices.order("created_at")
  end

  def create
    @notice = @shop.notices.build(notice_params)
    if @notice.save
      flash[:success] = "お知らせが作成されました。"
      redirect_to  admin_shop_admin_index_url
    else
      @notices = @shop.notices.order("created_at")
      flash.now[:danger] = "お知らせの作成に失敗しました。"
      render "admin_shop/notices/index", status: :unprocessable_entity
    end
  end

  def edit
    @notice = @shop.notices.find(params[:id])
  end

  def update
    @notice = @shop.notices.find(params[:id])
    if @notice.update(notice_params)
      flash[:success] = "お知らせが更新されました。"
      redirect_to admin_shop_notices_url
    else
      flash.now[:danger] = "お知らせの更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notice = @shop.notices.find(params[:id])
    @notice.destroy
    flash[:success] = "お知らせが削除されました。"
    redirect_to admin_shop_notices_url
  end

  private
  def notice_params
    params.require(:notice).permit(:title, :content, :date, :image, :remove_image)
  end
end
