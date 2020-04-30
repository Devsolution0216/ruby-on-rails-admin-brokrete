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

ActiveRecord::Schema.define(version: 2019_11_05_131447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "account_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.uuid "transaction_id", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount", null: false
    t.index ["account_id"], name: "index_account_transactions_on_account_id"
    t.index ["transaction_id"], name: "index_account_transactions_on_transaction_id"
  end

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "balance", default: 0
    t.integer "credit", default: 0
    t.datetime "credit_expired_at"
    t.string "name"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "country_id", null: false
    t.string "name"
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.jsonb "location_details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["latitude", "longitude"], name: "index_cities_on_latitude_and_longitude"
    t.index ["location_details"], name: "index_cities_on_location_details", using: :gin
  end

  create_table "configs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_id"
    t.uuid "plant_id"
    t.uuid "city_id"
    t.string "type"
    t.jsonb "value", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_configs_on_city_id"
    t.index ["plant_id"], name: "index_configs_on_plant_id"
    t.index ["supplier_id"], name: "index_configs_on_supplier_id"
    t.index ["value"], name: "index_configs_on_value", using: :gin
  end

  create_table "contractor_identities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contractor_id"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.boolean "active", default: true
    t.string "reset_token"
    t.datetime "reset_token_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_contractor_identities_on_confirmation_token"
    t.index ["contractor_id"], name: "index_contractor_identities_on_contractor_id"
    t.index ["provider", "uid"], name: "index_contractor_identities_on_provider_and_uid", unique: true
    t.index ["reset_token"], name: "index_contractor_identities_on_reset_token"
  end

  create_table "contractors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "account_id"
    t.index ["account_id"], name: "index_contractors_on_account_id"
    t.index ["details"], name: "index_contractors_on_details", using: :gin
    t.index ["user_id"], name: "index_contractors_on_user_id"
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fee_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fee_id", null: false
    t.uuid "supplier_id"
    t.uuid "product_id"
    t.uuid "city_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content", default: "unit"
    t.index ["city_id"], name: "index_fee_prices_on_city_id"
    t.index ["fee_id"], name: "index_fee_prices_on_fee_id"
    t.index ["product_id"], name: "index_fee_prices_on_product_id"
    t.index ["supplier_id"], name: "index_fee_prices_on_supplier_id"
  end

  create_table "fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.json "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type", default: "common"
  end

  create_table "option_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "option_id", null: false
    t.uuid "supplier_id"
    t.uuid "plant_id"
    t.uuid "city_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content", default: "unit"
    t.index ["city_id"], name: "index_option_prices_on_city_id"
    t.index ["option_id"], name: "index_option_prices_on_option_id"
    t.index ["plant_id"], name: "index_option_prices_on_plant_id"
    t.index ["supplier_id"], name: "index_option_prices_on_supplier_id"
  end

  create_table "options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 0
    t.index ["details"], name: "index_options_on_details", using: :gin
  end

  create_table "order_fees", force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "fee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fee_id"], name: "index_order_fees_on_fee_id"
    t.index ["order_id"], name: "index_order_fees_on_order_id"
  end

  create_table "order_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "option_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_id"], name: "index_order_options_on_option_id"
    t.index ["order_id"], name: "index_order_options_on_order_id"
  end

  create_table "order_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "product_strength_price_id"
    t.uuid "product_decorate_price_id"
    t.uuid "option_price_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "fee_price_id"
    t.index ["fee_price_id"], name: "index_order_prices_on_fee_price_id"
    t.index ["option_price_id"], name: "index_order_prices_on_option_price_id"
    t.index ["order_id"], name: "index_order_prices_on_order_id"
    t.index ["product_decorate_price_id"], name: "index_order_prices_on_product_decorate_price_id"
    t.index ["product_strength_price_id"], name: "index_order_prices_on_product_strength_price_id"
  end

  create_table "order_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "order_id", null: false
    t.uuid "transaction_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_transactions_on_order_id"
    t.index ["transaction_id"], name: "index_order_transactions_on_transaction_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.uuid "product_strength_id", null: false
    t.uuid "product_decorate_id"
    t.uuid "city_id", null: false
    t.integer "quantity"
    t.integer "total_price"
    t.jsonb "details", default: {}, null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.jsonb "location_details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "new"
    t.uuid "contractor_id"
    t.uuid "plant_id"
    t.index ["city_id"], name: "index_orders_on_city_id"
    t.index ["contractor_id"], name: "index_orders_on_contractor_id"
    t.index ["details"], name: "index_orders_on_details", using: :gin
    t.index ["latitude", "longitude"], name: "index_orders_on_latitude_and_longitude"
    t.index ["location_details"], name: "index_orders_on_location_details", using: :gin
    t.index ["plant_id"], name: "index_orders_on_plant_id"
    t.index ["product_decorate_id"], name: "index_orders_on_product_decorate_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["product_strength_id"], name: "index_orders_on_product_strength_id"
  end

  create_table "plant_availability_times", force: :cascade do |t|
    t.uuid "plant_id"
    t.string "status"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plant_id"], name: "index_plant_availability_times_on_plant_id"
  end

  create_table "plant_products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "plant_id", null: false
    t.uuid "product_id", null: false
    t.uuid "product_decorate_id"
    t.uuid "product_strength_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plant_id"], name: "index_plant_products_on_plant_id"
    t.index ["product_decorate_id"], name: "index_plant_products_on_product_decorate_id"
    t.index ["product_id"], name: "index_plant_products_on_product_id"
    t.index ["product_strength_id"], name: "index_plant_products_on_product_strength_id"
  end

  create_table "plants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_id", null: false
    t.uuid "city_id", null: false
    t.string "name"
    t.decimal "delivery_radius", precision: 10, scale: 6, null: false
    t.jsonb "details", default: {}, null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.jsonb "location_details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_plants_on_city_id"
    t.index ["details"], name: "index_plants_on_details", using: :gin
    t.index ["latitude", "longitude"], name: "index_plants_on_latitude_and_longitude"
    t.index ["location_details"], name: "index_plants_on_location_details", using: :gin
    t.index ["supplier_id"], name: "index_plants_on_supplier_id"
  end

  create_table "product_decorate_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_decorate_id", null: false
    t.uuid "supplier_id"
    t.uuid "plant_id"
    t.uuid "city_id"
    t.uuid "contractor_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content", default: "unit"
    t.index ["city_id"], name: "index_product_decorate_prices_on_city_id"
    t.index ["contractor_id"], name: "index_product_decorate_prices_on_contractor_id"
    t.index ["plant_id"], name: "index_product_decorate_prices_on_plant_id"
    t.index ["product_decorate_id"], name: "index_product_decorate_prices_on_product_decorate_id"
    t.index ["supplier_id"], name: "index_product_decorate_prices_on_supplier_id"
  end

  create_table "product_decorates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.string "name"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 0
    t.index ["details"], name: "index_product_decorates_on_details", using: :gin
    t.index ["product_id"], name: "index_product_decorates_on_product_id"
  end

  create_table "product_strength_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_strength_id", null: false
    t.uuid "supplier_id"
    t.uuid "plant_id"
    t.uuid "city_id"
    t.uuid "contractor_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content", default: "unit"
    t.index ["city_id"], name: "index_product_strength_prices_on_city_id"
    t.index ["contractor_id"], name: "index_product_strength_prices_on_contractor_id"
    t.index ["plant_id"], name: "index_product_strength_prices_on_plant_id"
    t.index ["product_strength_id"], name: "index_product_strength_prices_on_product_strength_id"
    t.index ["supplier_id"], name: "index_product_strength_prices_on_supplier_id"
  end

  create_table "product_strengths", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.string "name"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 0
    t.index ["details"], name: "index_product_strengths_on_details", using: :gin
    t.index ["product_id"], name: "index_product_strengths_on_product_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 0
    t.index ["details"], name: "index_products_on_details", using: :gin
  end

  create_table "suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contractor_id"
    t.string "provider"
    t.string "type", default: "charge", null: false
    t.string "status", default: "success", null: false
    t.string "currency", null: false
    t.integer "amount", null: false
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_transactions_on_contractor_id"
    t.index ["details"], name: "index_transactions_on_details", using: :gin
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "account_type"
    t.boolean "active", default: true
    t.integer "sign_in_count", default: 0
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "account_transactions", "accounts"
  add_foreign_key "account_transactions", "transactions"
  add_foreign_key "cities", "countries"
  add_foreign_key "configs", "cities"
  add_foreign_key "configs", "plants"
  add_foreign_key "configs", "suppliers"
  add_foreign_key "contractors", "accounts"
  add_foreign_key "fee_prices", "cities"
  add_foreign_key "fee_prices", "fees"
  add_foreign_key "fee_prices", "products"
  add_foreign_key "fee_prices", "suppliers"
  add_foreign_key "option_prices", "cities"
  add_foreign_key "option_prices", "options"
  add_foreign_key "option_prices", "plants"
  add_foreign_key "option_prices", "suppliers"
  add_foreign_key "order_fees", "fees"
  add_foreign_key "order_fees", "orders"
  add_foreign_key "order_options", "options"
  add_foreign_key "order_options", "orders"
  add_foreign_key "order_prices", "fee_prices"
  add_foreign_key "order_prices", "option_prices"
  add_foreign_key "order_prices", "orders"
  add_foreign_key "order_prices", "product_decorate_prices"
  add_foreign_key "order_prices", "product_strength_prices"
  add_foreign_key "order_transactions", "orders"
  add_foreign_key "order_transactions", "transactions"
  add_foreign_key "orders", "cities"
  add_foreign_key "orders", "contractors"
  add_foreign_key "orders", "plants"
  add_foreign_key "orders", "product_decorates"
  add_foreign_key "orders", "product_strengths"
  add_foreign_key "orders", "products"
  add_foreign_key "plant_availability_times", "plants"
  add_foreign_key "plant_products", "plants"
  add_foreign_key "plant_products", "product_decorates"
  add_foreign_key "plant_products", "product_strengths"
  add_foreign_key "plant_products", "products"
  add_foreign_key "plants", "cities"
  add_foreign_key "plants", "suppliers"
  add_foreign_key "product_decorate_prices", "cities"
  add_foreign_key "product_decorate_prices", "contractors"
  add_foreign_key "product_decorate_prices", "plants"
  add_foreign_key "product_decorate_prices", "product_decorates"
  add_foreign_key "product_decorate_prices", "suppliers"
  add_foreign_key "product_decorates", "products"
  add_foreign_key "product_strength_prices", "cities"
  add_foreign_key "product_strength_prices", "contractors"
  add_foreign_key "product_strength_prices", "plants"
  add_foreign_key "product_strength_prices", "product_strengths"
  add_foreign_key "product_strength_prices", "suppliers"
  add_foreign_key "product_strengths", "products"
end
