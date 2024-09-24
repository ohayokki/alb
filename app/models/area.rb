class Area < ApplicationRecord
  belongs_to :prefecture
  belongs_to :district
  has_many :shops

  validates :name, presence: true
  attr_accessor :new_district_name
  def display_name
    I18n.t("areas.#{name}", default: name)
  end
end
