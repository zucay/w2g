class AddFileioAndActiveToSpots < ActiveRecord::Migration
  def change
    add_column :projects, :active, :boolean, :default => true
    add_column :projects, :fileio, :string
  end
end
