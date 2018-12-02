class RenameTypeToIssueTypeToSupportTickets < ActiveRecord::Migration
  def change
  	rename_column :support_tickets, :type, :issue_type
  end
end
