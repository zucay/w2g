class ChangecolHeaders < ActiveRecord::Migration
  def up
    rename_column(:headers, :header_name, :name)
  end

  def down
    rename_column(:headers, :name, :header_name)
  end
end
