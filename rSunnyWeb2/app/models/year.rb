class Year < ActiveRecord::Base
	has_many :months
	has_many :days, :through => :months

	def sum_months()
		self.sum_unit0 = 0
		self.sum_unit1 = 0
		self.months.each do |i|
			self.sum_unit0 += i.sum_unit0
			self.sum_unit1 += i.sum_unit1
		end
		self.save
	end
end
