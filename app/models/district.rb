class District < ApplicationRecord
  belongs_to :prefecture
  has_many :areas
  has_many :shops

  def localized_name
    I18n.t("districts.#{name}", default: name)
  end
end
