class RemoveUserIdFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :user_id, :integer
  end
end
