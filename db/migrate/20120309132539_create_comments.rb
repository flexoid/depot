class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :product_id

      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.timestamps
    end
  end
end
