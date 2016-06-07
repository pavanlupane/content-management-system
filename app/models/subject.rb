class Subject < ActiveRecord::Base

	# has_one :page
	has_many :pages

	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order("subjects.created_at ASC")}
	scope :newest_first, lambda { order("subjects.created_at DESC") }
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%" ])
	}
end
