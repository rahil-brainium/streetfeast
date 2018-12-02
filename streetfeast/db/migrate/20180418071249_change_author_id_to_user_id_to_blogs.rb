class ChangeAuthorIdToUserIdToBlogs < ActiveRecord::Migration
  def change
  	rename_column :blogs, :author_id, :user_id
  end
end
