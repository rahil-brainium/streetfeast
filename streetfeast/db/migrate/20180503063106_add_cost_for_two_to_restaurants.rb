class AddCostForTwoToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :cost_for_two, :integer
  end
end
