class AddTypeAndActiveToSpots < ActiveRecord::Migration
  def change
    add_column :projects, :active, :boolean, :default => true
    add_column :projects, :type, :string
  end
end
