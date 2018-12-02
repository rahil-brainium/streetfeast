class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :address_line
      t.integer :restaurant_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
