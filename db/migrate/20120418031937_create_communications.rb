class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer "caretaker_id"
      t.integer "spot_id"
      t.string  "how"
      t.string  "deadline"
      t.string  "status"
      t.integer "note_id"
      t.timestamps
    end
  end
end
