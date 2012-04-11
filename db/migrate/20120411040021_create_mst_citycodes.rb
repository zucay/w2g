class CreateMstCitycodes < ActiveRecord::Migration
  def change
    create_table :mst_citycodes do |t|
      t.date     "valid_date"
      t.string   "code"
      t.string   "pref"
      t.string   "city"
      t.string   "town"
      t.integer  "city_len"
      t.integer  "town_len"
      t.string   "city_yomi"
      t.string   "town_yomi"
      t.timestamps
    end
  end
end
