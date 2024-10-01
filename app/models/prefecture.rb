class Prefecture < ApplicationRecord
  has_many :districts
  has_many :areas
  has_many :shops
  has_many :notices

  def display_name
    I18n.t("prefectures.#{name}")
  end
end
