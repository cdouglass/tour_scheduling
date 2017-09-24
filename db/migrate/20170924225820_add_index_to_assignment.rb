class AddIndexToAssignment < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :timeslots, :boats, table_name: :assignments

    create_table :assignments do |t|
      t.integer :timeslot_id, null: false
      t.integer :boat_id, null: false
      t.index :timeslot_id
      t.index :boat_id
    end
  end
end
