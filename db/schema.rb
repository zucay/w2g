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

ActiveRecord::Schema.define(:version => 20120411033548) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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
    t.integer  "gid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
