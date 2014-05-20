class Page < ActiveRecord::Base
	# pages table should have foreign key for subject
	belongs_to :subject
	has_and_belongs_to_many :editors, :class_name => "AdminUser" # :join_table => "admin_user_pages"
end
