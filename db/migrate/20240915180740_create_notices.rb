class CreateNotices < ActiveRecord::Migration[7.2]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :content
      t.date :date
      t.references :shop, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
