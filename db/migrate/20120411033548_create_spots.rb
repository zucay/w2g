class CreateSpots < ActiveRecord::Migration
  def change
    info_col_num = 15
    create_table :spots do |t|
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
      t.integer  "gid"
      t.timestamps
    end
  end
end
