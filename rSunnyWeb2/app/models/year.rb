class Year < ActiveRecord::Base
	has_many :months
	has_many :days, :through => :months 
end
