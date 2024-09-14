class Prefecture < ApplicationRecord
  has_many :districts
  has_many :areas
  has_many :shops

  def display_name
    I18n.t("prefectures.#{name}")
  end
end
