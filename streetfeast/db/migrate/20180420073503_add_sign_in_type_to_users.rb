class AddSignInTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_type, :string,:default => ""
  end
end
