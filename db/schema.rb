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

ActiveRecord::Schema[7.0].define(version: 2023_07_27_100932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "customer_id"
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "zip"
    t.string "phone"
    t.string "province_code"
    t.string "country_code"
    t.string "country_name"
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "canceled_orders", force: :cascade do |t|
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer "shopify_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "accepts_marketing"
    t.datetime "accepts_marketing_updated_at"
    t.string "tags"
    t.boolean "verified_email"
    t.string "state"
    t.integer "last_order_id"
    t.string "last_order_name"
    t.integer "orders_count"
    t.string "total_spent"
    t.boolean "tax_exempt"
    t.string "multipass_identifier"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discount_allocations", force: :cascade do |t|
    t.decimal "amount"
    t.integer "discount_application_index"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id"], name: "index_discount_allocations_on_line_item_id"
  end

  create_table "email_marketing_consents", force: :cascade do |t|
    t.integer "customer_id"
    t.string "state"
    t.string "opt_in_level"
    t.datetime "consent_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "shopify_id"
    t.integer "fulfillable_quantity"
    t.string "fulfillment_service"
    t.string "fulfillment_status"
    t.boolean "gift_card"
    t.integer "grams"
    t.string "name"
    t.decimal "price"
    t.boolean "product_exists"
    t.integer "product_id"
    t.integer "quantity"
    t.boolean "requires_shipping"
    t.string "sku"
    t.boolean "taxable"
    t.string "title"
    t.decimal "total_discount"
    t.integer "variant_id"
    t.string "variant_inventory_management"
    t.string "variant_title"
    t.string "vendor"
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
  end

  create_table "metafields", force: :cascade do |t|
    t.integer "customer_id"
    t.string "key"
    t.string "namespace"
    t.string "value"
    t.string "value_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "shopify_id"
    t.string "name"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_sets", force: :cascade do |t|
    t.json "shop_money"
    t.json "presentment_money"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id"], name: "index_price_sets_on_line_item_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "position"
    t.integer "width"
    t.integer "height"
    t.string "src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_option_values", force: :cascade do |t|
    t.bigint "product_option_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_option_id"], name: "index_product_option_values_on_product_option_id"
  end

  create_table "product_options", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_options_on_product_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "barcode"
    t.string "compare_at_price"
    t.string "fulfillment_service"
    t.integer "grams"
    t.decimal "weight"
    t.string "weight_unit"
    t.integer "inventory_item_id"
    t.string "inventory_management"
    t.string "inventory_policy"
    t.integer "inventory_quantity"
    t.string "option1"
    t.decimal "price"
    t.boolean "requires_shipping"
    t.string "sku"
    t.boolean "taxable"
    t.integer "position"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "shopify_id"
    t.text "body_html"
    t.string "handle"
    t.string "product_type"
    t.datetime "published_at"
    t.string "published_scope"
    t.string "status"
    t.string "tags"
    t.string "template_suffix"
    t.string "vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id"], name: "index_properties_on_line_item_id"
  end

  create_table "sms_marketing_consents", force: :cascade do |t|
    t.integer "customer_id"
    t.string "state"
    t.string "opt_in_level"
    t.datetime "consent_updated_at"
    t.string "consent_collected_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_lines", force: :cascade do |t|
    t.boolean "channel_liable"
    t.decimal "price"
    t.decimal "rate"
    t.string "title"
    t.bigint "line_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id"], name: "index_tax_lines_on_line_item_id"
  end

  add_foreign_key "discount_allocations", "line_items"
  add_foreign_key "line_items", "orders"
  add_foreign_key "price_sets", "line_items"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_option_values", "product_options"
  add_foreign_key "product_options", "products"
  add_foreign_key "product_variants", "products"
  add_foreign_key "properties", "line_items"
  add_foreign_key "tax_lines", "line_items"
end
