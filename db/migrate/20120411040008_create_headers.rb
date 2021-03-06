class CreateHeaders < ActiveRecord::Migration
  def change
    names = Spot.column_names - %w[id created_at updated_at]
    names = %w[pic] + names
    create_table :headers do |t|
      t.string 'header_name'
      names.each do |name| 
        if(name =~ /(_id|_content_type|_file_size|_updated_at)/)
          next
        end

        t.boolean "#{name}_active"
        t.boolean "#{name}_not_null"
        t.string "#{name}_label"
        t.string  "#{name}_example"
        t.string "#{name}_desc"
      end
      
      t.timestamps
    end
  end
end
