class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :associated_blogs
      t.string :name
      t.text :description
      t.string :operator
      t.time :opening_time
      t.time :closing_time
      t.float :latitude
      t.float :longitude
      t.boolean :is_blacklisted

      t.timestamps
    end
  end
end
