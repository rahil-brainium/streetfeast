class Blog < ActiveRecord::Base
	has_many :pictures
	belongs_to :user
	belongs_to :restaurant
end

