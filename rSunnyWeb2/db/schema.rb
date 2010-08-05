# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100805191516) do

  create_table "days", :force => true do |t|
    t.date     "date"
    t.text     "csvData"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sum_unit0"
    t.float    "sum_unit1"
    t.integer  "month_id"
  end

  add_index "days", ["month_id"], :name => "index_days_on_month_id"

  create_table "months", :force => true do |t|
    t.integer  "month"
    t.float    "sum_unit0"
    t.float    "sum_unit1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year_number"
    t.integer  "year_id"
  end

  add_index "months", ["year_id"], :name => "index_months_on_year_id"

  create_table "years", :force => true do |t|
    t.integer  "year"
    t.float    "sum_unit0"
    t.float    "sum_unit1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
