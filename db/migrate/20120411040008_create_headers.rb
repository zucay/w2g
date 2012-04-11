class CreateHeaders < ActiveRecord::Migration
  def change
    info_col_num = 15
    create_table :headers do |t|
      info_col_num.times do |i|
        t.string  "name_#{i}"
        t.boolean "active_#{i}"
        t.string  "description_#{i}"
        t.string  "example_#{i}"
      end
      t.timestamps
    end
  end
end
