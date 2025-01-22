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

ActiveRecord::Schema[8.0].define(version: 2025_01_22_203831) do
  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "weather_data"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "weathers", force: :cascade do |t|
    t.integer "locations_id", null: false
    t.date "date"
    t.float "high"
    t.float "low"
    t.string "description"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locations_id"], name: "index_weathers_on_locations_id"
  end

  add_foreign_key "weathers", "locations", column: "locations_id"
end
