class AdminShop::ShopsController < ApplicationController
  before_action :shop_signed_in?

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = "店舗情報修正しました。"
      redirect_to admin_shop_admin_index_url
    else
      flash.now[:danger] = "店舗情報修正に失敗しました。"
      render "admin_shop/admin/shopedit", status: :unprocessable_entity
    end
  end

  def set_vacant
    @shop = shop_obj

    # ユーザーが選択した時間を params から取得
    vacant_hours = params[:vacant_time].to_i
    wait_time = vacant_hours.hours
    if vacant_hours > 0 && !@shop.vacant_until.present?
      @shop.update(vacant_time: wait_time, vacant_until: Time.current + vacant_hours.hours)

      # ジョブを予約して、指定した時間が過ぎた後に vacant_time を nil にする
      ClearVacantStatusJob.set(wait: vacant_hours.hours).perform_later(@shop.id)

      flash[:success] = "空席状況を更新しました。#{vacant_hours}時間後に空席状況が解除されます。"
    else
      flash[:danger] = "既に設定済みか無効な時間が選択されました。"
    end

    respond_to do |format|
      format.html { redirect_to admin_shop_shop_path(@shop) }
      format.js   # 非同期処理のためにJSでのレスポンスも用意
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_logo, :tel, :address, :hours, :holiday, :budget, :access,
     :title, :introduction, :website, :reservation, :wifi, :alcohol, :smoking, :english, :korean, :card_payment, :mobile_payment,
     :image1, :image2, :image3, :image4, :image5, weekly_holidays: [])
  end
end
