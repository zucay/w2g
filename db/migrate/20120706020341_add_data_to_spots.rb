class AddDataToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :data, :text
  end
end
