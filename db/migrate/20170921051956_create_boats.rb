class CreateBoats < ActiveRecord::Migration[5.1]
  def change
    create_table :boats do |t|
      t.string :name, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
