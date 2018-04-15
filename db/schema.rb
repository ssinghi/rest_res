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

ActiveRecord::Schema.define(version: 2018_04_15_193120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "guests", force: :cascade do |t|
    t.string "name", null: false
    t.citext "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.bigint "shift_id", null: false
    t.bigint "table_id", null: false
    t.datetime "time", null: false
    t.integer "guests_count", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["shift_id"], name: "index_reservations_on_shift_id"
    t.index ["table_id"], name: "index_reservations_on_table_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.citext "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.citext "name", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id", "name"], name: "index_shifts_on_restaurant_id_and_name", unique: true
    t.index ["restaurant_id"], name: "index_shifts_on_restaurant_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.citext "name", null: false
    t.integer "min_guests", limit: 2
    t.integer "max_guests", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id", "name"], name: "index_tables_on_restaurant_id_and_name", unique: true
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  add_foreign_key "reservations", "guests"
  add_foreign_key "reservations", "shifts"
  add_foreign_key "reservations", "tables"
  add_foreign_key "shifts", "restaurants"
  add_foreign_key "tables", "restaurants"
end
