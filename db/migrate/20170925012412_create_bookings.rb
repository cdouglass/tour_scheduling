class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :size
      t.integer :timeslot_id
      t.index :timeslot_id

      t.timestamps
    end
  end
end
