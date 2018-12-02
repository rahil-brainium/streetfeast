class CreateSupportTickets < ActiveRecord::Migration
  def change
    create_table :support_tickets do |t|
      t.integer :user_id
      t.text :issue_description

      t.timestamps
    end
  end
end
