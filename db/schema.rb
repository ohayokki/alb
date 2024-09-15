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

ActiveRecord::Schema[7.2].define(version: 2024_09_15_123137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "prefecture_id", null: false
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_areas_on_district_id"
    t.index ["prefecture_id"], name: "index_areas_on_prefecture_id"
  end

  create_table "costumes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "prefecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_districts_on_prefecture_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.string "rubi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.bigint "shop_id"
    t.integer "day_of_week"
    t.date "date"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_holidays_on_shop_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "manager_name"
    t.string "email"
    t.string "title"
    t.string "budget"
    t.string "shop_logo"
    t.string "tel"
    t.boolean "reservation"
    t.boolean "wifi"
    t.boolean "alcohol"
    t.boolean "smoking"
    t.boolean "english"
    t.boolean "korean"
    t.text "introduction"
    t.text "access"
    t.text "googlemap"
    t.string "hours"
    t.string "holiday"
    t.integer "weekly_holidays", default: [], array: true
    t.boolean "card_payment"
    t.string "card_company"
    t.boolean "mobile_payment"
    t.string "website"
    t.text "notes"
    t.boolean "coupon"
    t.string "address"
    t.text "area_description"
    t.bigint "area_id"
    t.bigint "prefecture_id"
    t.bigint "district_id"
    t.bigint "genre_id"
    t.float "latitude"
    t.float "longitude"
    t.string "image1"
    t.string "image2"
    t.string "image3"
    t.string "image4"
    t.string "image5"
    t.boolean "vacant_seat_inquiry", default: false
    t.string "password_digest"
    t.integer "status", default: 1, null: false
    t.datetime "tiral_start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_shops_on_area_id"
    t.index ["district_id"], name: "index_shops_on_district_id"
    t.index ["genre_id"], name: "index_shops_on_genre_id"
    t.index ["prefecture_id"], name: "index_shops_on_prefecture_id"
  end

  create_table "socials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "areas", "districts"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "districts", "prefectures"
  add_foreign_key "holidays", "shops"
end
