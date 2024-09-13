class CreateGenres < ActiveRecord::Migration[7.2]
  def change
    create_table :genres do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :rubi

      t.timestamps
    end
  end
end
