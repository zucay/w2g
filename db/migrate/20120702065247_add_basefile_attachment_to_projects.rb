class AddBasefileAttachmentToProjects < ActiveRecord::Migration
  def up
    change_table :projects do |t|
      t.has_attached_file :base_file
    end
  end
  def down
    drop_attached_file :projects, :base_file
  end
end
