class AddEmailFullnameToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :email, :string
    add_column :blogs, :fullname, :string
  end
end
