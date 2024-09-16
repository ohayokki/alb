class ClearVacantStatusJob < ApplicationJob
  queue_as :default

  def perform(shop_id)
    shop = Shop.find(shop_id)
    # vacant_until の時間が過ぎていたら vacant_time を nil にする
    if shop.vacant_until.present? && Time.current >= shop.vacant_until
      shop.update(vacant_time: nil, vacant_until: nil)
    end
  end
end
