class AddDragonflySupportToProducts < ActiveRecord::Migration
  def up
    add_column :products, :image_uid, :string
    remove_column :products, :image_url
  end

  def down
    add_column :products, :image_url, :string
    remove_column :products, :image_uid
  end
end
