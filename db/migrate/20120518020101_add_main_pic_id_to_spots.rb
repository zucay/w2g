class AddMainPicIdToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :main_pic_id, :integer
  end
end
