class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :item_name
      t.integer :price
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
