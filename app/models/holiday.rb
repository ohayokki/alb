class Holiday < ApplicationRecord
  belongs_to :shop

  enum status: { closed: 0, open: 1 } # closed: 定休日や臨時休業日、open: 営業日
  validates :date, presence: true
  validates :status, presence: true
  
end
