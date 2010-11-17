class AddChartArraysToDay < ActiveRecord::Migration
  def self.up
    add_column :days, :chart_array0, :text
    add_column :days, :chart_array1, :text
  end

  def self.down
    remove_column :days, :chart_array1
    remove_column :days, :chart_array0
  end
end
