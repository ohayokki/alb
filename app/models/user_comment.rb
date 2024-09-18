class UserComment < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :comment, presence: true
end
