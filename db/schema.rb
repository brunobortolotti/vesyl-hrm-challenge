# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_04_06_171009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hrm_data_points", id: false, force: :cascade do |t|
    t.bigint "hrm_session_id", null: false
    t.integer "beats_per_minute", null: false
    t.datetime "reading_started_at", null: false
    t.datetime "reading_ended_at", null: false
    t.integer "duration_in_seconds", null: false
  end

  create_table "hrm_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "duration_in_seconds", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "gender", null: false
    t.integer "age", null: false
    t.integer "hr_zone1_bpm_min", null: false
    t.integer "hr_zone1_bpm_max", null: false
    t.integer "hr_zone2_bpm_min", null: false
    t.integer "hr_zone2_bpm_max", null: false
    t.integer "hr_zone3_bpm_min", null: false
    t.integer "hr_zone3_bpm_max", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hrm_data_points", "hrm_sessions"
  add_foreign_key "hrm_sessions", "users"
end
