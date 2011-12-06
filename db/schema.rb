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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110927234831) do

  create_table "basisgraphs", :id => false, :force => true do |t|
    t.integer "weight", :null => false
    t.integer "height", :null => false
    t.float   "1",      :null => false
    t.float   "2",      :null => false
    t.float   "3",      :null => false
    t.float   "4",      :null => false
    t.float   "5",      :null => false
    t.float   "6",      :null => false
    t.float   "7",      :null => false
    t.float   "8",      :null => false
  end

  create_table "bmibasis", :id => false, :force => true do |t|
    t.float "bmi", :null => false
    t.float "1"
    t.float "2"
    t.float "3"
    t.float "4"
    t.float "5"
    t.float "6"
    t.float "7"
    t.float "8"
  end

  create_table "bmis", :force => true do |t|
    t.integer  "age"
    t.string   "race"
    t.string   "gender"
    t.string   "activity_level"
    t.integer  "weight_lb"
    t.integer  "weight_kg"
    t.integer  "height_inch"
    t.integer  "height_feet"
    t.integer  "height_cm"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fulldataweights", :id => false, :force => true do |t|
    t.integer "year",                    :null => false
    t.string  "gender",     :limit => 1, :null => false
    t.integer "age",                     :null => false
    t.string  "race",       :limit => 1, :null => false
    t.float   "population",              :null => false
    t.float   "1",                       :null => false
    t.float   "2",                       :null => false
    t.float   "3",                       :null => false
    t.float   "4",                       :null => false
    t.float   "5",                       :null => false
    t.float   "6",                       :null => false
    t.float   "7",                       :null => false
    t.float   "8",                       :null => false
  end

end
