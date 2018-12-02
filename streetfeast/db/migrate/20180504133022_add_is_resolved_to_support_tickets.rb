class AddIsResolvedToSupportTickets < ActiveRecord::Migration
  def change
    add_column :support_tickets, :is_resolved, :boolean,default: false
  end
end
