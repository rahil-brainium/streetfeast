class RemoveIssueTypeFromSupportTickets < ActiveRecord::Migration
  def change
    remove_column :support_tickets, :issue_type, :string
  end
end
