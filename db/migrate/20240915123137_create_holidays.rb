class CreateHolidays < ActiveRecord::Migration[7.2]
  def change
    create_table :holidays do |t|
      t.references :shop, foreign_key: true
      t.integer :day_of_week         # 繰り返し定休日の場合に使用
      t.date :date                   # 例外日や臨時休業日
      t.integer :status, null: false # open または closed

      t.timestamps
    end
  end
end
