class ChangeContactNumberIntegerToStringInRestaurants < ActiveRecord::Migration
  def change
  	change_column :restaurants, :contact_number, :string
  end
end
