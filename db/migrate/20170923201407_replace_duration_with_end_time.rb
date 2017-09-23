class ReplaceDurationWithEndTime < ActiveRecord::Migration[5.1]
  def change
    change_table :timeslots do |t|
      t.integer :end_time, null: false, default: -1
      t.index :end_time
      t.change_default :start_time, from: nil, to: 0
      t.index :start_time
    end
    change_column_null :timeslots, :start_time, from: true, to: false
    remove_column :timeslots, :duration, :integer, null: false, default: 0
  end
end
