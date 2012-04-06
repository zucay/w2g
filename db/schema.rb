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

ActiveRecord::Schema.define(:version => 20120404072717) do

  create_table "caretakers", :force => true do |t|
    t.string   "name"
    t.string   "div_name"
    t.string   "person"
    t.string   "person_yomi"
    t.string   "addr"
    t.string   "email"
    t.string   "tel"
    t.string   "fax"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "ext_id"
    t.integer  "note_id"
    t.string   "zipcode"
  end

  create_table "headers", :force => true do |t|
    t.string  "name_0"
    t.boolean "active_0"
    t.string  "description_0"
    t.string  "example_0"
    t.string  "name_1"
    t.boolean "active_1"
    t.string  "description_1"
    t.string  "example_1"
    t.string  "name_2"
    t.boolean "active_2"
    t.string  "description_2"
    t.string  "example_2"
    t.string  "name_3"
    t.boolean "active_3"
    t.string  "description_3"
    t.string  "example_3"
    t.string  "name_4"
    t.boolean "active_4"
    t.string  "description_4"
    t.string  "example_4"
    t.string  "name_5"
    t.boolean "active_5"
    t.string  "description_5"
    t.string  "example_5"
    t.string  "name_6"
    t.boolean "active_6"
    t.string  "description_6"
    t.string  "example_6"
    t.string  "name_7"
    t.boolean "active_7"
    t.string  "description_7"
    t.string  "example_7"
    t.string  "name_8"
    t.boolean "active_8"
    t.string  "description_8"
    t.string  "example_8"
    t.string  "name_9"
    t.boolean "active_9"
    t.string  "description_9"
    t.string  "example_9"
    t.string  "name_10"
    t.boolean "active_10"
    t.string  "description_10"
    t.string  "example_10"
    t.string  "name_11"
    t.boolean "active_11"
    t.string  "description_11"
    t.string  "example_11"
    t.string  "name_12"
    t.boolean "active_12"
    t.string  "description_12"
    t.string  "example_12"
    t.string  "name_13"
    t.boolean "active_13"
    t.string  "description_13"
    t.string  "example_13"
    t.string  "name_14"
    t.boolean "active_14"
    t.string  "description_14"
    t.string  "example_14"
  end

  create_table "mst_citycodes", :force => true do |t|
    t.date     "valid_date"
    t.string   "code"
    t.string   "pref"
    t.string   "city"
    t.string   "town"
    t.integer  "city_len"
    t.integer  "town_len"
    t.string   "city_yomi"
    t.string   "town_yomi"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spots", :force => true do |t|
    t.string   "name"
    t.string   "yomi"
    t.string   "pref"
    t.string   "city"
    t.string   "addr"
    t.string   "zipcode"
    t.string   "build_name"
    t.string   "tel"
    t.integer  "lat_256jp"
    t.integer  "lng_256jp"
    t.float    "lat_world"
    t.float    "lng_world"
    t.string   "hour"
    t.string   "holiday"
    t.string   "spot_fee"
    t.boolean  "has_park"
    t.string   "park_num"
    t.string   "park_fee"
    t.boolean  "tollway"
    t.string   "url"
    t.string   "access_train"
    t.string   "access_car"
    t.string   "about_title"
    t.string   "about_body"
    t.string   "info_0"
    t.string   "info_1"
    t.string   "info_2"
    t.string   "info_3"
    t.string   "info_4"
    t.string   "info_5"
    t.string   "info_6"
    t.string   "info_7"
    t.string   "info_8"
    t.string   "info_9"
    t.string   "info_10"
    t.string   "info_11"
    t.string   "info_12"
    t.string   "info_13"
    t.string   "info_14"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.boolean  "checked"
    t.boolean  "caretaker_inputed"
    t.integer  "user_id"
    t.integer  "caretaker_id"
    t.integer  "project_id"
    t.integer  "header_id"
    t.integer  "note_id"
    t.boolean  "deny",               :default => false
    t.string   "ext_id"
    t.integer  "linenum"
    t.boolean  "active"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "gid"
  end

end
