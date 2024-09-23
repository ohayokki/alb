class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :manager_name
      t.string :email
      t.string :title
      t.integer :budget #平均予算
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
      t.string :holiday # 定休日説明文
      t.integer :weekly_holidays, array: true, default: [] #定休日保存用
      t.boolean :card_payment
      t.string :card_company
      t.boolean :mobile_payment
      t.string :website
      t.text :notes
      t.text :coupon, default: nil
      t.string :address
      t.text :area_description
      t.references :area
      t.references :prefecture
      t.references :district
      t.references :genre
      t.float :latitude
      t.float :longitude
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :image4
      t.string :image5
      t.string :vacant_job_id, default: nil # 空席中JobのID
      t.datetime :vacant_until, default: nil #空席中の終了時間
      t.string :password_digest, default: nil
      t.integer :status, default: 1, null: false
      t.datetime :tiral_start_date, default: nil # 無料掲載開始日 １度だけOK初期値nil
      t.timestamps
    end
  end
end
