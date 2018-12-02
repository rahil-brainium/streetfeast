class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :mobile_no, :string
  	add_column :users, :city, :string
  	add_column :users, :is_blocked, :boolean
  	add_column :users, :is_admin, :boolean
  end
end
