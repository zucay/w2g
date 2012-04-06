class Initialschema < ActiveRecord::Migration
  def up
    info_col_num = 15
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

      info_col_num.times do |i|
        t.string "info_#{i}"
      end

      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.string   "photo_file_size"

      t.boolean  "checked"
      t.boolean  "caretaker_inputed"

      # relation
      t.integer  "user_id"
      t.integer  "caretaker_id"
      t.integer  "project_id"
      t.integer  "header_id"
      t.integer  "note_id"

      t.boolean  "deny", :default => false
      t.string   "ext_id"
      t.integer  "linenum"
      t.boolean  "active"

      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "gid"
    end
    create_table "headers", :force => true do |t|
      info_col_num.times do |i|
        t.string  "name_#{i}"
        t.boolean "active_#{i}"
        t.string  "description_#{i}"
        t.string  "example_#{i}"
      end
    end
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
    create_table "notes", :force => true do |t|
      t.text     "text"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
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
  end
  
  def down
    drop_table "spots"
    drop_table "headers"
    drop_table "caretakers"
    drop_table "notes"
    drop_table "mst_citycodes"
  end
end
