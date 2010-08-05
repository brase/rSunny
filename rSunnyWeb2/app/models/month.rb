class Month < ActiveRecord::Base
	has_many :days
	belongs_to :year
end
