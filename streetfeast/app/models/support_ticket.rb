class SupportTicket < ActiveRecord::Base
	belongs_to :user
	has_one :issue_type
end
