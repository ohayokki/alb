class CreateUserComments < ActiveRecord::Migration[7.2]
  def change
    create_table :user_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.text :comment, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
