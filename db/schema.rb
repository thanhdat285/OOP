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

ActiveRecord::Schema.define(version: 20170906075000) do

  create_table "films", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "image"
    t.string "kind"
    t.string "duration"
    t.text "content"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.json "seats"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "film_id"
    t.bigint "location_id"
    t.bigint "room_id"
    t.datetime "time_begin"
    t.datetime "time_end"
    t.bigint "user_sell_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_schedules_on_film_id"
    t.index ["location_id"], name: "index_schedules_on_location_id"
    t.index ["room_id"], name: "index_schedules_on_room_id"
    t.index ["user_sell_id"], name: "index_schedules_on_user_sell_id"
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "price"
    t.integer "user_buy_id"
    t.string "seat_row"
    t.integer "seat_col"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_tickets_on_schedule_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "role"
    t.string "email"
    t.string "password"
    t.string "avatar"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance", default: 100000
    t.index ["location_id"], name: "index_users_on_location_id"
  end

  add_foreign_key "rooms", "locations"
  add_foreign_key "schedules", "films"
  add_foreign_key "schedules", "locations"
  add_foreign_key "schedules", "users", column: "user_sell_id"
  add_foreign_key "tickets", "schedules"
  add_foreign_key "users", "locations"
end
