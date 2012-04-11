class CreateHeaders < ActiveRecord::Migration
  def change

    names = Spot.column_names - %w[id created_at updated_at]

    create_table :headers do |t|
      t.string 'name'
      names.each do |name| 
        t.string "label_#{name}"
        t.string "desc_#{name}"
        t.boolean "active_#{name}"
        t.string  "example_#{name}"
      end
      t.timestamps
    end
=begin    
    info_col_num = 15
    
      info_col_num.times do |i|
        t.string  "name_#{i}"
        t.boolean "active_#{i}"
        t.string  "description_#{i}"
        t.string  "example_#{i}"
      end
      t.timestamps
    end
=end
  end
end
