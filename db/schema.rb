# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140803080301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "english_name"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_values", force: true do |t|
    t.integer  "company_id"
    t.date     "date"
    t.integer  "total_shares",       limit: 8
    t.integer  "circulating_shares", limit: 8
    t.decimal  "price",                        precision: 7, scale: 3
    t.decimal  "pe_ttm",                       precision: 9, scale: 3
    t.decimal  "pb",                           precision: 9, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_values", ["company_id", "date"], name: "index_daily_values_on_company_id_and_date", unique: true, using: :btree

  create_table "exchanges", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "english_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "index_dailies", force: true do |t|
    t.integer  "index_id"
    t.date     "date"
    t.decimal  "market_value", precision: 25, scale: 3
    t.decimal  "earnings_ttm", precision: 25, scale: 3
    t.decimal  "books",        precision: 25, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "index_dailies", ["index_id", "date"], name: "index_index_dailies_on_index_id_and_date", unique: true, using: :btree

  create_table "index_items", force: true do |t|
    t.integer  "index_id"
    t.integer  "company_id"
    t.decimal  "weight",     precision: 5, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "index_items", ["index_id", "company_id"], name: "index_index_items_on_index_id_and_company_id", unique: true, using: :btree

  create_table "indices", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "english_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
