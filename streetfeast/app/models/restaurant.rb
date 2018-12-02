class Restaurant < ActiveRecord::Base
	has_many :blogs
	has_many :addresses
	has_many :pictures
	accepts_nested_attributes_for :addresses
	has_many :menus
end
