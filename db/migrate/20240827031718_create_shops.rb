class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :manager_name
      t.string :email
      t.string :title
      t.string :budget
      t.string :shop_logo
      t.string :tel
      t.boolean :reservation
      t.boolean :wifi
      t.boolean :alcohol
      t.boolean :smoking
      t.boolean :english
      t.boolean :korean
      t.text :introduction
      t.text :access
      t.text :googlemap
      t.string :hours
      t.string :holiday
      t.boolean :card_payment
      t.string :card_company
      t.boolean :mobile_payment
      t.string :website
      t.text :notes
      t.boolean :coupon
      t.string :address
      t.text :area_description
      t.references :area
      t.references :prefecture
      t.references :district
      t.references :genre
      t.float :latitude
      t.float :longitude
      t.integer :status, default: 1, null: false
      t.datetime :tiral_start_date, default: nil # 無料掲載開始日 １度だけOK初期値nil
      t.timestamps
    end
  end
end
