class Holiday < ApplicationRecord
  belongs_to :shop

  enum status: { closed: 0, open: 1 } # closed: 定休日や臨時休業日、open: 営業日
  validates :date, presence: true
  validates :status, presence: true

  # 特定の日付が営業日か休業日かを返す
  def self.status_for_date(shop, date)
    holiday = shop.holidays.find_by(date: date)
    holiday ? holiday.status : nil
  end
end
