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

ActiveRecord::Schema.define(:version => 20120411040030) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
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

  create_table "caretakers", :force => true do |t|
    t.string   "name"
    t.string   "div_name"
    t.string   "person"
    t.string   "person_yomi"
    t.string   "addr"
    t.string   "email"
    t.string   "tel"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ext_id"
    t.integer  "note_id"
    t.string   "zipcode"
  end

  create_table "headers", :force => true do |t|
    t.string   "name"
    t.boolean  "name_active"
    t.string   "name_label"
    t.string   "name_desc"
    t.boolean  "name_not_null"
    t.string   "name_example"
    t.boolean  "yomi_active"
    t.string   "yomi_label"
    t.string   "yomi_desc"
    t.boolean  "yomi_not_null"
    t.string   "yomi_example"
    t.boolean  "pref_active"
    t.string   "pref_label"
    t.string   "pref_desc"
    t.boolean  "pref_not_null"
    t.string   "pref_example"
    t.boolean  "city_active"
    t.string   "city_label"
    t.string   "city_desc"
    t.boolean  "city_not_null"
    t.string   "city_example"
    t.boolean  "addr_active"
    t.string   "addr_label"
    t.string   "addr_desc"
    t.boolean  "addr_not_null"
    t.string   "addr_example"
    t.boolean  "zipcode_active"
    t.string   "zipcode_label"
    t.string   "zipcode_desc"
    t.boolean  "zipcode_not_null"
    t.string   "zipcode_example"
    t.boolean  "build_name_active"
    t.string   "build_name_label"
    t.string   "build_name_desc"
    t.boolean  "build_name_not_null"
    t.string   "build_name_example"
    t.boolean  "tel_active"
    t.string   "tel_label"
    t.string   "tel_desc"
    t.boolean  "tel_not_null"
    t.string   "tel_example"
    t.boolean  "lat_256jp_active"
    t.string   "lat_256jp_label"
    t.string   "lat_256jp_desc"
    t.boolean  "lat_256jp_not_null"
    t.string   "lat_256jp_example"
    t.boolean  "lng_256jp_active"
    t.string   "lng_256jp_label"
    t.string   "lng_256jp_desc"
    t.boolean  "lng_256jp_not_null"
    t.string   "lng_256jp_example"
    t.boolean  "lat_world_active"
    t.string   "lat_world_label"
    t.string   "lat_world_desc"
    t.boolean  "lat_world_not_null"
    t.string   "lat_world_example"
    t.boolean  "lng_world_active"
    t.string   "lng_world_label"
    t.string   "lng_world_desc"
    t.boolean  "lng_world_not_null"
    t.string   "lng_world_example"
    t.boolean  "hour_active"
    t.string   "hour_label"
    t.string   "hour_desc"
    t.boolean  "hour_not_null"
    t.string   "hour_example"
    t.boolean  "holiday_active"
    t.string   "holiday_label"
    t.string   "holiday_desc"
    t.boolean  "holiday_not_null"
    t.string   "holiday_example"
    t.boolean  "spot_fee_active"
    t.string   "spot_fee_label"
    t.string   "spot_fee_desc"
    t.boolean  "spot_fee_not_null"
    t.string   "spot_fee_example"
    t.boolean  "has_park_active"
    t.string   "has_park_label"
    t.string   "has_park_desc"
    t.boolean  "has_park_not_null"
    t.string   "has_park_example"
    t.boolean  "park_num_active"
    t.string   "park_num_label"
    t.string   "park_num_desc"
    t.boolean  "park_num_not_null"
    t.string   "park_num_example"
    t.boolean  "park_fee_active"
    t.string   "park_fee_label"
    t.string   "park_fee_desc"
    t.boolean  "park_fee_not_null"
    t.string   "park_fee_example"
    t.boolean  "tollway_active"
    t.string   "tollway_label"
    t.string   "tollway_desc"
    t.boolean  "tollway_not_null"
    t.string   "tollway_example"
    t.boolean  "url_active"
    t.string   "url_label"
    t.string   "url_desc"
    t.boolean  "url_not_null"
    t.string   "url_example"
    t.boolean  "access_train_active"
    t.string   "access_train_label"
    t.string   "access_train_desc"
    t.boolean  "access_train_not_null"
    t.string   "access_train_example"
    t.boolean  "access_car_active"
    t.string   "access_car_label"
    t.string   "access_car_desc"
    t.boolean  "access_car_not_null"
    t.string   "access_car_example"
    t.boolean  "about_title_active"
    t.string   "about_title_label"
    t.string   "about_title_desc"
    t.boolean  "about_title_not_null"
    t.string   "about_title_example"
    t.boolean  "about_body_active"
    t.string   "about_body_label"
    t.string   "about_body_desc"
    t.boolean  "about_body_not_null"
    t.string   "about_body_example"
    t.boolean  "pic0_file_name_active"
    t.string   "pic0_file_name_label"
    t.string   "pic0_file_name_desc"
    t.boolean  "pic0_file_name_not_null"
    t.string   "pic0_file_name_example"
    t.boolean  "pic0_content_type_active"
    t.string   "pic0_content_type_label"
    t.string   "pic0_content_type_desc"
    t.boolean  "pic0_content_type_not_null"
    t.string   "pic0_content_type_example"
    t.boolean  "pic0_file_size_active"
    t.string   "pic0_file_size_label"
    t.string   "pic0_file_size_desc"
    t.boolean  "pic0_file_size_not_null"
    t.string   "pic0_file_size_example"
    t.boolean  "pic0_updated_at_active"
    t.string   "pic0_updated_at_label"
    t.string   "pic0_updated_at_desc"
    t.boolean  "pic0_updated_at_not_null"
    t.string   "pic0_updated_at_example"
    t.boolean  "pic1_file_name_active"
    t.string   "pic1_file_name_label"
    t.string   "pic1_file_name_desc"
    t.boolean  "pic1_file_name_not_null"
    t.string   "pic1_file_name_example"
    t.boolean  "pic1_content_type_active"
    t.string   "pic1_content_type_label"
    t.string   "pic1_content_type_desc"
    t.boolean  "pic1_content_type_not_null"
    t.string   "pic1_content_type_example"
    t.boolean  "pic1_file_size_active"
    t.string   "pic1_file_size_label"
    t.string   "pic1_file_size_desc"
    t.boolean  "pic1_file_size_not_null"
    t.string   "pic1_file_size_example"
    t.boolean  "pic1_updated_at_active"
    t.string   "pic1_updated_at_label"
    t.string   "pic1_updated_at_desc"
    t.boolean  "pic1_updated_at_not_null"
    t.string   "pic1_updated_at_example"
    t.boolean  "pic2_file_name_active"
    t.string   "pic2_file_name_label"
    t.string   "pic2_file_name_desc"
    t.boolean  "pic2_file_name_not_null"
    t.string   "pic2_file_name_example"
    t.boolean  "pic2_content_type_active"
    t.string   "pic2_content_type_label"
    t.string   "pic2_content_type_desc"
    t.boolean  "pic2_content_type_not_null"
    t.string   "pic2_content_type_example"
    t.boolean  "pic2_file_size_active"
    t.string   "pic2_file_size_label"
    t.string   "pic2_file_size_desc"
    t.boolean  "pic2_file_size_not_null"
    t.string   "pic2_file_size_example"
    t.boolean  "pic2_updated_at_active"
    t.string   "pic2_updated_at_label"
    t.string   "pic2_updated_at_desc"
    t.boolean  "pic2_updated_at_not_null"
    t.string   "pic2_updated_at_example"
    t.boolean  "pic3_file_name_active"
    t.string   "pic3_file_name_label"
    t.string   "pic3_file_name_desc"
    t.boolean  "pic3_file_name_not_null"
    t.string   "pic3_file_name_example"
    t.boolean  "pic3_content_type_active"
    t.string   "pic3_content_type_label"
    t.string   "pic3_content_type_desc"
    t.boolean  "pic3_content_type_not_null"
    t.string   "pic3_content_type_example"
    t.boolean  "pic3_file_size_active"
    t.string   "pic3_file_size_label"
    t.string   "pic3_file_size_desc"
    t.boolean  "pic3_file_size_not_null"
    t.string   "pic3_file_size_example"
    t.boolean  "pic3_updated_at_active"
    t.string   "pic3_updated_at_label"
    t.string   "pic3_updated_at_desc"
    t.boolean  "pic3_updated_at_not_null"
    t.string   "pic3_updated_at_example"
    t.boolean  "pic4_file_name_active"
    t.string   "pic4_file_name_label"
    t.string   "pic4_file_name_desc"
    t.boolean  "pic4_file_name_not_null"
    t.string   "pic4_file_name_example"
    t.boolean  "pic4_content_type_active"
    t.string   "pic4_content_type_label"
    t.string   "pic4_content_type_desc"
    t.boolean  "pic4_content_type_not_null"
    t.string   "pic4_content_type_example"
    t.boolean  "pic4_file_size_active"
    t.string   "pic4_file_size_label"
    t.string   "pic4_file_size_desc"
    t.boolean  "pic4_file_size_not_null"
    t.string   "pic4_file_size_example"
    t.boolean  "pic4_updated_at_active"
    t.string   "pic4_updated_at_label"
    t.string   "pic4_updated_at_desc"
    t.boolean  "pic4_updated_at_not_null"
    t.string   "pic4_updated_at_example"
    t.boolean  "pic_info_active"
    t.string   "pic_info_label"
    t.string   "pic_info_desc"
    t.boolean  "pic_info_not_null"
    t.string   "pic_info_example"
    t.boolean  "info_0_active"
    t.string   "info_0_label"
    t.string   "info_0_desc"
    t.boolean  "info_0_not_null"
    t.string   "info_0_example"
    t.boolean  "info_1_active"
    t.string   "info_1_label"
    t.string   "info_1_desc"
    t.boolean  "info_1_not_null"
    t.string   "info_1_example"
    t.boolean  "info_2_active"
    t.string   "info_2_label"
    t.string   "info_2_desc"
    t.boolean  "info_2_not_null"
    t.string   "info_2_example"
    t.boolean  "info_3_active"
    t.string   "info_3_label"
    t.string   "info_3_desc"
    t.boolean  "info_3_not_null"
    t.string   "info_3_example"
    t.boolean  "info_4_active"
    t.string   "info_4_label"
    t.string   "info_4_desc"
    t.boolean  "info_4_not_null"
    t.string   "info_4_example"
    t.boolean  "info_5_active"
    t.string   "info_5_label"
    t.string   "info_5_desc"
    t.boolean  "info_5_not_null"
    t.string   "info_5_example"
    t.boolean  "info_6_active"
    t.string   "info_6_label"
    t.string   "info_6_desc"
    t.boolean  "info_6_not_null"
    t.string   "info_6_example"
    t.boolean  "info_7_active"
    t.string   "info_7_label"
    t.string   "info_7_desc"
    t.boolean  "info_7_not_null"
    t.string   "info_7_example"
    t.boolean  "info_8_active"
    t.string   "info_8_label"
    t.string   "info_8_desc"
    t.boolean  "info_8_not_null"
    t.string   "info_8_example"
    t.boolean  "info_9_active"
    t.string   "info_9_label"
    t.string   "info_9_desc"
    t.boolean  "info_9_not_null"
    t.string   "info_9_example"
    t.boolean  "info_10_active"
    t.string   "info_10_label"
    t.string   "info_10_desc"
    t.boolean  "info_10_not_null"
    t.string   "info_10_example"
    t.boolean  "info_11_active"
    t.string   "info_11_label"
    t.string   "info_11_desc"
    t.boolean  "info_11_not_null"
    t.string   "info_11_example"
    t.boolean  "info_12_active"
    t.string   "info_12_label"
    t.string   "info_12_desc"
    t.boolean  "info_12_not_null"
    t.string   "info_12_example"
    t.boolean  "info_13_active"
    t.string   "info_13_label"
    t.string   "info_13_desc"
    t.boolean  "info_13_not_null"
    t.string   "info_13_example"
    t.boolean  "info_14_active"
    t.string   "info_14_label"
    t.string   "info_14_desc"
    t.boolean  "info_14_not_null"
    t.string   "info_14_example"
    t.boolean  "checked_active"
    t.string   "checked_label"
    t.string   "checked_desc"
    t.boolean  "checked_not_null"
    t.string   "checked_example"
    t.boolean  "caretaker_inputed_active"
    t.string   "caretaker_inputed_label"
    t.string   "caretaker_inputed_desc"
    t.boolean  "caretaker_inputed_not_null"
    t.string   "caretaker_inputed_example"
    t.boolean  "user_id_active"
    t.string   "user_id_label"
    t.string   "user_id_desc"
    t.boolean  "user_id_not_null"
    t.string   "user_id_example"
    t.boolean  "caretaker_id_active"
    t.string   "caretaker_id_label"
    t.string   "caretaker_id_desc"
    t.boolean  "caretaker_id_not_null"
    t.string   "caretaker_id_example"
    t.boolean  "project_id_active"
    t.string   "project_id_label"
    t.string   "project_id_desc"
    t.boolean  "project_id_not_null"
    t.string   "project_id_example"
    t.boolean  "note_id_active"
    t.string   "note_id_label"
    t.string   "note_id_desc"
    t.boolean  "note_id_not_null"
    t.string   "note_id_example"
    t.boolean  "deny_active"
    t.string   "deny_label"
    t.string   "deny_desc"
    t.boolean  "deny_not_null"
    t.string   "deny_example"
    t.boolean  "ext_id_active"
    t.string   "ext_id_label"
    t.string   "ext_id_desc"
    t.boolean  "ext_id_not_null"
    t.string   "ext_id_example"
    t.boolean  "linenum_active"
    t.string   "linenum_label"
    t.string   "linenum_desc"
    t.boolean  "linenum_not_null"
    t.string   "linenum_example"
    t.boolean  "active_active"
    t.string   "active_label"
    t.string   "active_desc"
    t.boolean  "active_not_null"
    t.string   "active_example"
    t.boolean  "gid_active"
    t.string   "gid_label"
    t.string   "gid_desc"
    t.boolean  "gid_not_null"
    t.string   "gid_example"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "client"
    t.integer  "header_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "pic0_file_name"
    t.string   "pic0_content_type"
    t.integer  "pic0_file_size"
    t.datetime "pic0_updated_at"
    t.string   "pic1_file_name"
    t.string   "pic1_content_type"
    t.integer  "pic1_file_size"
    t.datetime "pic1_updated_at"
    t.string   "pic2_file_name"
    t.string   "pic2_content_type"
    t.integer  "pic2_file_size"
    t.datetime "pic2_updated_at"
    t.string   "pic3_file_name"
    t.string   "pic3_content_type"
    t.integer  "pic3_file_size"
    t.datetime "pic3_updated_at"
    t.string   "pic4_file_name"
    t.string   "pic4_content_type"
    t.integer  "pic4_file_size"
    t.datetime "pic4_updated_at"
    t.string   "pic_info"
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
    t.boolean  "checked"
    t.boolean  "caretaker_inputed"
    t.integer  "user_id"
    t.integer  "caretaker_id"
    t.integer  "project_id"
    t.integer  "note_id"
    t.boolean  "deny",              :default => false
    t.string   "ext_id"
    t.integer  "linenum"
    t.boolean  "active"
    t.integer  "gid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end