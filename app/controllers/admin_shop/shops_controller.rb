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
    if vacant_hours > 0 && !@shop.vacant_until.present?
      vacant_time = vacant_hours * 3600
      job = ClearVacantStatusJob.set(wait: vacant_time).perform_later(@shop.id)
      @shop.update!(vacant_job_id: job.job_id, vacant_until: (Time.current + vacant_time))

      flash[:success] = "空席状況を更新しました。#{vacant_hours}時間後に空席状況が解除されます。"
    else
      flash[:danger] = "既に設定済みか無効な時間が選択されました。"
    end

    respond_to do |format|
      format.html { redirect_to admin_shop_admin_index_url }
      format.js   # 非同期処理のためにJSでのレスポンスも用意
    end
  end

  def remove_vacant
    @shop = shop_obj

    if @shop.vacant_job_id.present?
      scheduled_jobs = Sidekiq::ScheduledSet.new

      scheduled_jobs.each do |job|
        # ジョブのクラス名を取得
        job_info = job.args.first # ここにはハッシュが入っている
        job_class = job_info["job_class"] if job_info.is_a?(Hash)
      
        # ジョブの引数を取得
        job_args = job_info["arguments"] if job_info.is_a?(Hash)
      
        # ジョブのクラス名と引数をチェックして削除
        if job_class == "ClearVacantStatusJob" && job_args.first.to_i == @shop.id
          job.delete
          Rails.logger.debug "Removed job with ID: #{job_info['job_id']}"
        end
      end
      @shop.update!(vacant_until: nil, vacant_job_id: nil)
    end

    flash[:success] = "空席状況を解除ししました。"
    respond_to do |format|
      format.html { redirect_to admin_shop_admin_index_url }
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
