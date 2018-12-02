class AddIssueTypeIdToSupportTickets < ActiveRecord::Migration
  def change
    add_column :support_tickets, :issue_type_id, :integer
  end
end
