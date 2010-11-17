class AddYearIdToMonth < ActiveRecord::Migration
  def self.up
		remove_column "months", "year"
		add_column "months", "year_number", :integer
		add_column "months", "year_id", :integer
    add_index "months", "year_id"
  end

  def self.down		
		remove_index "months", "year_id"
		remove_column "months", "year_id"
		remove_column "months", "year_number"
		add_column "months", "year", :integer
  end
end
