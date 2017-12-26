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

ActiveRecord::Schema.define(version: 20171226225656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "description"
    t.integer "rate"
    t.bigint "user_id"
    t.bigint "shop_owner_id"
    t.bigint "shop_id"
    t.string "reply"
    t.datetime "date_replied"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_reviews_on_shop_id"
    t.index ["shop_owner_id"], name: "index_reviews_on_shop_owner_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shop_admins", force: :cascade do |t|
    t.bigint "shop_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_admins_on_shop_id"
    t.index ["user_id"], name: "index_shop_admins_on_user_id"
  end

  create_table "shop_favourites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_favourites_on_shop_id"
    t.index ["user_id"], name: "index_shop_favourites_on_user_id"
  end

  create_table "shop_photos", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_photos_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.float "rate"
    t.float "lat"
    t.float "long"
    t.string "address"
    t.string "phone_number"
    t.string "main_photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "google_place_id"
    t.index ["category_id"], name: "index_shops_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "image_url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "account_type", default: "email"
    t.string "account_id"
    t.string "account_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  create_table "working_days", force: :cascade do |t|
    t.string "day_name"
    t.string "state"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "opened_at"
    t.time "closed_at"
    t.index ["shop_id"], name: "index_working_days_on_shop_id"
  end

  add_foreign_key "reviews", "shops"
  add_foreign_key "shop_admins", "shops"
  add_foreign_key "shop_admins", "users"
  add_foreign_key "shop_favourites", "shops"
  add_foreign_key "shop_favourites", "users"
  add_foreign_key "shop_photos", "shops"
  add_foreign_key "shops", "categories"
  add_foreign_key "working_days", "shops"
end
