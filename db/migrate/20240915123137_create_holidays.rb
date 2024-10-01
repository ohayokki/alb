class CreateHolidays < ActiveRecord::Migration[7.2]
  def change
    create_table :holidays do |t|
      t.references :shop, foreign_key: true
      t.date :date                   # 例外日や臨時休業日
      t.integer :status, null: false # open または closed

      t.timestamps
    end
  end
end
