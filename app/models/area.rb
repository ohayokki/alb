class Area < ApplicationRecord
  belongs_to :prefecture
  belongs_to :district
  has_many :shops

  def display_name
    I18n.t("areas.#{name}", default: name)
  end
end
