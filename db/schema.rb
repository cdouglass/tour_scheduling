# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170924064823) do

  create_table "assignments", id: false, force: :cascade do |t|
    t.integer "timeslot_id", null: false
    t.integer "boat_id", null: false
    t.index ["boat_id"], name: "index_assignments_on_boat_id"
    t.index ["timeslot_id"], name: "index_assignments_on_timeslot_id"
  end

  create_table "boats", force: :cascade do |t|
    t.string "name", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeslots", force: :cascade do |t|
    t.integer "start_time", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "end_time", default: -1, null: false
    t.index ["end_time"], name: "index_timeslots_on_end_time"
    t.index ["start_time"], name: "index_timeslots_on_start_time"
  end

end
