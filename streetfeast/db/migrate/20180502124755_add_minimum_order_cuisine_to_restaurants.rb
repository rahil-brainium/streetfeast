class AddMinimumOrderCuisineToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :minimum_order, :integer
    add_column :restaurants, :cuisine, :string
  end
end
