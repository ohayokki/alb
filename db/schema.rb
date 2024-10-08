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

ActiveRecord::Schema[7.2].define(version: 2024_09_29_042005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "prefecture_id", null: false
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_areas_on_district_id"
    t.index ["prefecture_id"], name: "index_areas_on_prefecture_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "inquiry_type"
    t.text "inquiry_details"
    t.boolean "status", default: false, null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.bigint "shop_id"
    t.date "date"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_holidays_on_shop_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.date "date"
    t.bigint "shop_id", null: false
    t.bigint "prefecture_id", null: false
    t.bigint "district_id", null: false
    t.bigint "area_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_notices_on_area_id"
    t.index ["district_id"], name: "index_notices_on_district_id"
    t.index ["prefecture_id"], name: "index_notices_on_prefecture_id"
    t.index ["shop_id"], name: "index_notices_on_shop_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_relationships_on_shop_id"
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "relationshops", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_relationshops_on_shop_id"
    t.index ["user_id"], name: "index_relationshops_on_user_id"
  end

  create_table "shop_labels", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "label_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_shop_labels_on_label_id"
    t.index ["shop_id"], name: "index_shop_labels_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "manager_name"
    t.string "email"
    t.string "title"
    t.integer "budget"
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
    t.boolean "qr_code_payment"
    t.string "qr_code_company"
    t.boolean "e_money_payment"
    t.string "e_money_company"
    t.string "website"
    t.text "notes"
    t.text "coupon"
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
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "tiktok"
    t.string "youtube"
    t.string "vacant_job_id"
    t.datetime "vacant_until"
    t.string "password_digest"
    t.integer "status", default: 1, null: false
    t.datetime "trial_start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access"], name: "index_shops_on_access", opclass: :gin_trgm_ops, using: :gin
    t.index ["area_id"], name: "index_shops_on_area_id"
    t.index ["coupon"], name: "index_shops_on_coupon", opclass: :gin_trgm_ops, using: :gin
    t.index ["district_id"], name: "index_shops_on_district_id"
    t.index ["genre_id"], name: "index_shops_on_genre_id"
    t.index ["introduction"], name: "index_shops_on_introduction", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "index_shops_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["prefecture_id"], name: "index_shops_on_prefecture_id"
    t.index ["title"], name: "index_shops_on_title", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "staffs", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "name"
    t.string "blood_type"
    t.date "birthday"
    t.integer "height"
    t.string "alcohol"
    t.text "message"
    t.string "image"
    t.string "hobby"
    t.string "role"
    t.string "service_style"
    t.string "qualifications"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_staffs_on_shop_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.text "comment", null: false
    t.integer "score", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_user_comments_on_shop_id"
    t.index ["user_id"], name: "index_user_comments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "line_uid"
    t.string "name"
    t.string "image_url"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "areas", "districts"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "districts", "prefectures"
  add_foreign_key "holidays", "shops"
  add_foreign_key "notices", "areas"
  add_foreign_key "notices", "districts"
  add_foreign_key "notices", "prefectures"
  add_foreign_key "notices", "shops"
  add_foreign_key "relationships", "shops"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationshops", "shops"
  add_foreign_key "relationshops", "users"
  add_foreign_key "shop_labels", "labels"
  add_foreign_key "shop_labels", "shops"
  add_foreign_key "staffs", "shops"
  add_foreign_key "user_comments", "shops"
  add_foreign_key "user_comments", "users"
end
