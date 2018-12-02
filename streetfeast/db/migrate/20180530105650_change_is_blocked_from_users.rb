class ChangeIsBlockedFromUsers < ActiveRecord::Migration
  def change
  	change_column_default :users, :is_blocked, false
  end
end
