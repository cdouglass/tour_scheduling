class CreateTimeslots < ActiveRecord::Migration[5.1]
  def change
    create_table :timeslots do |t|
      t.integer :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
