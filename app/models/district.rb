class District < ApplicationRecord
  belongs_to :prefecture
  has_many :areas
  has_many :shops
  has_many :notices

  def display_name
    I18n.t("districts.#{name}", default: name)
  end
end
