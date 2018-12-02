class AddClosedOnToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :closed_on, :string
  end
end
