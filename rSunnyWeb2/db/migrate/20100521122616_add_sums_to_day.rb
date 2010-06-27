class AddSumsToDay < ActiveRecord::Migration
  def self.up    
    add_column "days", "sum_unit0", :float    
    add_column "days", "sum_unit1", :float    
  end

  def self.down
    remove_column "days", "sum_unit0"
    remove_column "days", "sum_unit1"
  end
end
