class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :picture_id
      t.integer :user_id
      t.boolean :is_liked,default: false

      t.timestamps
    end
  end
end
