class ChangeOpeningTimeClosingTimeToStringToRestaurants < ActiveRecord::Migration
  def change

  	change_column :restaurants, :opening_time, :string
  	change_column :restaurants, :closing_time, :string

  end
end
