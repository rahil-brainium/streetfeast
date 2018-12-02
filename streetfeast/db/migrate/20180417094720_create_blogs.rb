class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.integer :author_id
      t.boolean :is_reviewd
      t.boolean :is_blocked

      t.timestamps
    end
  end
end
