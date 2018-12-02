class AddContactNumberToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :contact_number, :integer
  end
end
