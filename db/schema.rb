# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_24_133617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_days", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "bookable_day_id"
    t.index ["bookable_day_id"], name: "index_available_days_on_bookable_day_id"
    t.index ["listing_id"], name: "index_available_days_on_listing_id"
  end

  create_table "bookable_days", force: :cascade do |t|
    t.datetime "days"
  end

  create_table "booking_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "listing_id"
    t.string "guest"
    t.datetime "requested_date"
    t.bigint "bookable_day_id"
    t.index ["bookable_day_id"], name: "index_booking_requests_on_bookable_day_id"
    t.index ["listing_id"], name: "index_booking_requests_on_listing_id"
    t.index ["user_id"], name: "index_booking_requests_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "requested_date"
    t.integer "listing_id"
    t.bigint "bookable_day_id"
    t.index ["bookable_day_id"], name: "index_bookings_on_bookable_day_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "listing_id"
    t.string "image"
    t.index ["listing_id"], name: "index_images_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.string "location"
    t.string "photo_src"
    t.integer "user_id"
    t.string "test"
    t.datetime "available_date"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "name"
  end

end
