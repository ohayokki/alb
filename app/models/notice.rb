class Notice < ApplicationRecord
  mount_uploader :image, NoticeUploader
  belongs_to :shop
  belongs_to :prefecture, optional: true
  belongs_to :district, optional: true
  belongs_to :area, optional: true
  before_save :set_location

  validates :title, presence: true
  validates :date, presence: true

  private

  def set_location
    self.area = shop.area
    self.district = shop.district
    self.prefecture = shop.prefecture
  end
end
