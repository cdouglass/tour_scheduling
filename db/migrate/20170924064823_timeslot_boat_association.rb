class TimeslotBoatAssociation < ActiveRecord::Migration[5.1]
  def change
    create_join_table :timeslots, :boats, table_name: :assignments do |t|
      t.index :timeslot_id
      t.index :boat_id
    end
  end
end
