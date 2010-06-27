class Day < ActiveRecord::Migration
  def self.up
    add_column :days, :csvData, :text
  end

  def self.down
    remove_column :days, :csvData
  end
end
