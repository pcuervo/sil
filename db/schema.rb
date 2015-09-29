# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150929193331) do

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "client_contacts", force: :cascade do |t|
    t.string   "first_name",    default: "",  null: false
    t.string   "phone"
    t.string   "phone_ext",     default: "-"
    t.string   "email",         default: "",  null: false
    t.string   "business_unit"
    t.integer  "client_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "last_name",     default: ""
  end

  add_index "client_contacts", ["client_id"], name: "index_client_contacts_on_client_id"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string   "name",         default: " "
    t.text     "description",  default: " "
    t.string   "image_url",    default: "default_item.png"
    t.string   "status",       default: "active"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "actable_id"
    t.string   "actable_type"
    t.integer  "project_id"
    t.integer  "client_id"
    t.string   "item_type",    default: "otro"
    t.string   "code_url",     default: "no_code.png"
  end

  add_index "inventory_items", ["client_id"], name: "index_inventory_items_on_client_id"
  add_index "inventory_items", ["project_id"], name: "index_inventory_items_on_project_id"
  add_index "inventory_items", ["user_id"], name: "index_inventory_items_on_user_id"

  create_table "logs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sys_module"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "actor_id"
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name",       default: "Empty project"
    t.string   "litobel_id", default: "-"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",    default: 1
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "unit_items", force: :cascade do |t|
    t.string   "serial_number", default: " "
    t.string   "brand",         default: " "
    t.string   "model",         default: " "
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                 null: false
    t.string   "encrypted_password",     default: "",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "auth_token",             default: ""
    t.integer  "role",                   default: 1,                  null: false
    t.string   "last_name"
    t.string   "name"
    t.string   "image_url",              default: "default_user.png"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
