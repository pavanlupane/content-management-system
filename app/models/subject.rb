class Subject < ActiveRecord::Base

	# has_one :page
	has_many :pages

	acts_as_list

	after_save :touch_page

	validates_presence_of :name
	validates_length_of :name, :maximum => 255

	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order("subjects.created_at ASC")}
	scope :newest_first, lambda { order("subjects.created_at DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%" ])
	}

	private
		def touch_page
			# touch is similar to:
			# subject.update_attribute(:updated_at, Time.now)
			page.touch
		end
end
