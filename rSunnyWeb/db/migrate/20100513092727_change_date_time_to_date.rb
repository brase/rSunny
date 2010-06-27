class ChangeDateTimeToDate < ActiveRecord::Migration
  def self.up
    remove_column :days, :datetime
    add_column :days, :datetime, :date
  end

  def self.down
    remove_column :days, :datetime
    add_column :days, :datetime, :datetime
  end
end
