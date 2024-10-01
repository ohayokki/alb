class CreateStaffs < ActiveRecord::Migration[7.2]
  def change
    create_table :staffs do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.string :blood_type
      t.date :birthday
      t.integer :height
      t.string :alcohol
      t.text :message
      t.string :image
      t.string :hobby
      t.string :role
      t.string :service_style
      t.string :qualifications

      t.timestamps
    end
  end
end
