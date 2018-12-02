class AddIsAvailableToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :is_available, :boolean,default: true
  end
end
