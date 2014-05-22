class Page < ActiveRecord::Base
	# pages table should have foreign key for subject
	belongs_to :subject
	has_and_belongs_to_many :editors, :class_name => "AdminUser" # :join_table => "admin_user_pages"
	has_many :sections

	# can have same page 1 for 2 different subject
	acts_as_list :scope => :subject

	before_validation :add_default_permalink
	after_save :touch_subject
	after_destroy :delete_related_sections

	validates_presence_of :name	
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, within: 3..255
	validates_uniqueness_of :permalink

	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order("pages.position ASC") }
	scope :newest_first, lambda { order("pages.created_at DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	private 
		def add_default_permalink
			if permalink.blank?
				self.permalink = "#{id}-#{name.prameterize}"
			end
		end

		def touch_subject
			# touch is similar to:
			# subject.update_attribute(:updated_at, Time.now)
			subject.touch
		end

		def delete_related_sections
			self.sections.each do |section|
				section.destroy
			end
		end
end
