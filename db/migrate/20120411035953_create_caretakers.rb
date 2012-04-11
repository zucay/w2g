class CreateCaretakers < ActiveRecord::Migration
  def change
    create_table :caretakers do |t|
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
      t.timestamps
    end
  end
end
