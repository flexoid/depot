class AddDragonflySupportToProducts < ActiveRecord::Migration
  def change

    add_column :products, :image_uid, :string
    remove_column :products, :image_url
  end
end
