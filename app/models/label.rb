class Label < ApplicationRecord
  has_many :shop_labels
  has_many :shops, through: :shop_labels

  validates :name, presence: true, uniqueness: true
end
