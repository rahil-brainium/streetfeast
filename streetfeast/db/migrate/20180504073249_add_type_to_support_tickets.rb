class AddTypeToSupportTickets < ActiveRecord::Migration
  def change
    add_column :support_tickets, :type, :string
  end
end
