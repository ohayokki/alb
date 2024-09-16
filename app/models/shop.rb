class Shop < ApplicationRecord
  mount_uploader :image1, ShopUploader
  mount_uploader :image2, ShopUploader
  mount_uploader :image3, ShopUploader
  mount_uploader :image4, ShopUploader
  mount_uploader :image5, ShopUploader
  mount_uploader :shop_logo, ShopLogoUploader
  has_secure_password
  attr_accessor :distance #仮想属性（お店までの距離）
  enum status: { "掲載依頼": 1, "無料掲載": 2, "お試し有料掲載": 3, "有料掲載": 4, "閉店": 5 }
  
  has_many :holidays
  has_many :notices
  belongs_to :area, optional: true
  belongs_to :prefecture, optional: true
  belongs_to :district, optional: true
  belongs_to :genre


  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } 
  validates :area_id, :prefecture_id, :district_id, presence: true, on: :create_shop
  validates :area_id, presence: true, on: :update_shop
  validates :prefecture_id, presence: true, on: :update_shop
  validates :district_id, presence: true, on: :update_shop

  validates :manager_name, presence: true
  validates :address, presence: true
  validates :area_description, presence: true

  #パスワードバリデーション
  validates :password, length: { minimum: 8 }, if: :password_required?
  validates :password, format: { 
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}\z/, 
    message: "は少なくとも1つの小文字、大文字、数字、特殊文字を含む必要があります"
  }, if: -> { password.present? }

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

  # パスワードが必要な場合にバリデーションを行う
  def password_required?
    new_record? || password.present?
  end

  def holidays_for_month(year, month)
    holidays = []

    # 月の日数をループして、曜日や特別営業日/休業日を考慮する
    (1..Time.days_in_month(month, year)).each do |day|
      date = Date.new(year, month, day)

      # 特別な営業日や休業日がある場合は優先
      holiday_status = Holiday.status_for_date(self, date)
      if holiday_status == 'closed'
        holidays << date # 休業日として扱う
      elsif holiday_status.nil? && weekly_holidays.include?(date.wday)
        holidays << date # 定休日として扱う
      end
    end

    holidays
  end

  # 現在時刻より前で、vacant_until がnil ではない店舗
  scope :vacant_expired, -> { where("vacant_until <= ?", Time.current).where.not(vacant_until: nil) }
  # 空席の終了時間を計算し、vacant_untilに保存するメソッド
  def set_vacant_time(hours)
    self.vacant_until = Time.current + hours.hours
    self.vacant_time = hours
    save
  end

  # 空席の状態を更新するメソッド
  def update_vacant_status
    if vacant_until.present? && Time.current >= vacant_until
      self.vacant_time = nil
      self.vacant_until = nil
      save
    end
  end
end
