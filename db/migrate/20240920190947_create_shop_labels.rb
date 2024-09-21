class CreateShopLabels < ActiveRecord::Migration[7.2]
  def change
    create_table :shop_labels do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
