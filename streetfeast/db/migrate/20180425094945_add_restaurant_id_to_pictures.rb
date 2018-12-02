class AddRestaurantIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :restaurant_id, :integer
  end
end
