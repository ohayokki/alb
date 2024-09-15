class Holiday < ApplicationRecord
  belongs_to :shop

  enum status: { closed: 0, open: 1 } # closed: 定休日や臨時休業日、open: 営業日
  validates :date, presence: true, if: :specific_date?

  # 繰り返しの定休日用（曜日ベース）
  enum day_of_week: { sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6 }, _prefix: true

  # 特定の日付が必要かどうかを判定するメソッド
  def specific_date?
    day_of_week.nil? # day_of_weekがない場合、特定の日付が必要
  end
end
