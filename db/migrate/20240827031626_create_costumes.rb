class CreateCostumes < ActiveRecord::Migration[7.2]
  def change
    create_table :costumes do |t|
      t.timestamps
    end
  end
end
