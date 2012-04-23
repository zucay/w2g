class AddMemoToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :memo, :string
  end
end
