class ClearVacantStatusJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    Rails.logger.error("ジョブの失敗: #{exception.message}")
  end

  def perform(shop_id)
    shop = Shop.find(shop_id)

    if shop.vacant_until.present? && Time.current >= shop.vacant_until
      @shop.update!(vacant_until: nil, vacant_job_id: nil)
    end
  end
end
