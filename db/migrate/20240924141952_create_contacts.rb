class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :inquiry_type
      t.text :inquiry_details
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
