class ChangeIsReviewdToReviewedToBlogs < ActiveRecord::Migration
  def change
  	rename_column :blogs, :is_reviewd, :is_reviewed
  end
end
