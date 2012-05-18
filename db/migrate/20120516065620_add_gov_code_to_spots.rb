class AddGovCodeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :govcode, :string
  end
end
