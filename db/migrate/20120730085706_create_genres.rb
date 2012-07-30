class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name
      t.integer :position
      t.boolean :active, :default => true
      t.boolean :public, :default => false

      t.timestamps
    end
  end
end
