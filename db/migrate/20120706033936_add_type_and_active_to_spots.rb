class AddTypeAndActiveToSpots < ActiveRecord::Migration
  def change
    add_column :projects, :genre, :string
    add_column :projects, :active, :boolean, :default => true
    add_column :projects, :type, :string
    add_column :projects, :public, :boolean, :default => false
    add_column :projects, :description, :text
  end
end
