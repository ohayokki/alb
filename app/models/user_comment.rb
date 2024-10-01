class UserComment < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
