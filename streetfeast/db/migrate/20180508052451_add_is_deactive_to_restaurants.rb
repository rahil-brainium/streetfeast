class AddIsDeactiveToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :is_deactive, :boolean,default: false
  end
end
