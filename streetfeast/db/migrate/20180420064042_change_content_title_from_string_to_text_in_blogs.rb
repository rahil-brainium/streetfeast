class ChangeContentTitleFromStringToTextInBlogs < ActiveRecord::Migration
  def change
  	change_column :blogs, :content, :text
  end
end
