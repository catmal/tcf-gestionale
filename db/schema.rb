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

ActiveRecord::Schema[7.1].define(version: 2023_11_26_191121) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_of_material_lines", force: :cascade do |t|
    t.bigint "component_id"
    t.bigint "group_id"
    t.decimal "quantity"
    t.bigint "bill_of_material_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_of_material_id"], name: "index_bill_of_material_lines_on_bill_of_material_id"
    t.index ["component_id"], name: "index_bill_of_material_lines_on_component_id"
    t.index ["group_id"], name: "index_bill_of_material_lines_on_group_id"
  end

  create_table "bill_of_materials", force: :cascade do |t|
    t.date "date"
    t.string "number"
    t.string "purchase_order_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_connections", id: false, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "type"
    t.string "pdf_url"
    t.string "dxf_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "supplier_order_lines", force: :cascade do |t|
    t.bigint "supplier_order_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_supplier_order_lines_on_item_id"
    t.index ["supplier_order_id"], name: "index_supplier_order_lines_on_supplier_order_id"
  end

  create_table "supplier_orders", force: :cascade do |t|
    t.string "number"
    t.bigint "supplier_id", null: false
    t.date "date"
    t.bigint "bill_of_material_id", null: false
    t.string "machine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_of_material_id"], name: "index_supplier_orders_on_bill_of_material_id"
    t.index ["supplier_id"], name: "index_supplier_orders_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bill_of_material_lines", "bill_of_materials"
  add_foreign_key "bill_of_material_lines", "items", column: "component_id"
  add_foreign_key "bill_of_material_lines", "items", column: "group_id"
  add_foreign_key "item_connections", "items", column: "child_id"
  add_foreign_key "item_connections", "items", column: "parent_id"
  add_foreign_key "supplier_order_lines", "items"
  add_foreign_key "supplier_order_lines", "supplier_orders"
  add_foreign_key "supplier_orders", "bill_of_materials"
  add_foreign_key "supplier_orders", "suppliers"
end
