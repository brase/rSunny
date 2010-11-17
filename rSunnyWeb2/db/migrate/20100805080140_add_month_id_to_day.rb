class AddMonthIdToDay < ActiveRecord::Migration
  def self.up
    add_column "days", "month_id", :integer
    add_index "days", "month_id"
  end

  def self.down
    remove_index "days", "month_id"
    remove_column "days", "month_id"
  end
end
