class CreateMonths < ActiveRecord::Migration
  def self.up
    create_table :months do |t|
      t.integer :year
      t.integer :month
      t.float :sum_unit0
      t.float :sum_unit1

      t.timestamps
    end
  end

  def self.down
    drop_table :months
  end
end
