class RemoveMinimumOrderFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :minimum_order, :string
  end
end
