class RemoveImageUidFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :image_uid
      end

  def down
    add_column :products, :image_uid, :string
  end
end
