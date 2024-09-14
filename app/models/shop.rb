class Shop < ApplicationRecord
  mount_uploader :shop_logo, ShopLogoUploader
  attr_accessor :distance #仮想属性（お店までの距離）
  enum status: { "掲載依頼": 1, "無料掲載": 2, "お試し有料掲載": 3, "有料掲載": 4, "閉店": 5 }
  
  belongs_to :area, optional: true
  belongs_to :prefecture, optional: true
  belongs_to :district, optional: true
  belongs_to :genre

  validates :area_id, :prefecture_id, :district_id, presence: true, on: :create_shop
  validates :area_id, presence: true, on: :update_shop
  validates :prefecture_id, presence: true, on: :update_shop
  validates :district_id, presence: true, on: :update_shop

  validates :manager_name, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :area_description, presence: true

  # 緯度と経度のカラムを指定 todo: 将来実装
  # geocoded_by :address, latitude: :latitude, longitude: :longitude
  # after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # 逆ジオコーディングの設定（オプション）
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: :latitude_changed? && :longitude_changed?

  # お試し掲載中か判定する
  def trial_period_active?
    trial_start_date.present? && trial_start_date > 3.months.ago
  end

  # お試し期間が終了したら無料掲載にするメソッド
  def update_status_if_trial_ended
    if trial_start_date.present? && trial_start_date <= 3.months.ago
      update(status: "無料掲載")
    end
  end
end
