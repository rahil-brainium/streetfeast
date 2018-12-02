class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :avatar
      t.integer :blog_id
      t.integer :user_id

      t.timestamps
    end
  end
end
