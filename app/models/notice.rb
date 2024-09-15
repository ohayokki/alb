class Notice < ApplicationRecord
  mount_uploader :image, NoticeUploader
  belongs_to :shop

  validates :title, presence: true
  validates :date, presence: true
end
