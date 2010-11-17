class Month < ActiveRecord::Base
	has_many :days
	belongs_to :year

	def sum_days()
		self.sum_unit0 = 0
		self.sum_unit1 = 0
		self.days.each do |i|
			logger.debug i.sum_unit0
			self.sum_unit0 += i.sum_unit0
			self.sum_unit1 += i.sum_unit1
		end
		self.save
		self.year.sum_months
	end
end
