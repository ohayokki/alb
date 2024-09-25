class EnablePgTrgmExtension < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pg_trgm'

    add_index :shops, :name, using: :gin, opclass: :gin_trgm_ops
    add_index :shops, :title, using: :gin, opclass: :gin_trgm_ops
    add_index :shops, :introduction, using: :gin, opclass: :gin_trgm_ops
    add_index :shops, :access, using: :gin, opclass: :gin_trgm_ops
    add_index :shops, :coupon, using: :gin, opclass: :gin_trgm_ops
  end
end
