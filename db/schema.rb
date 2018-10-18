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

ActiveRecord::Schema.define(version: 2018_10_18_031441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.bigint "payment_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["payment_id"], name: "index_orders_on_payment_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "address_id"
    t.bigint "card_number"
    t.date "expiration_date"
    t.integer "cvv"
    t.string "card_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_payments_on_address_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.integer "price_in_cents"
    t.integer "quantity"
    t.string "category"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.text "review"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "is_a_seller"
    t.integer "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "payments"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "addresses"
  add_foreign_key "payments", "users"
  add_foreign_key "products", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
end
