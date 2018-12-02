class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
    	t.string :rating
      t.text :description
      t.string :viewers_ip
      t.string :viewers_city
      t.string :viewers_region
      t.string :viewers_country
      t.string :viewers_continent
      t.string :viewers_latitude
      t.string :viewers_longitude
      t.string :viewers_internet_service_provider

      t.timestamps
    end
  end
end
