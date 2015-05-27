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

ActiveRecord::Schema.define(version: 20150527161600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dashboard_widgets", id: false, force: true do |t|
    t.integer "dashboard_id"
    t.integer "widget_id"
  end

  add_index "dashboard_widgets", ["dashboard_id"], name: "index_dashboard_widgets_on_dashboard_id", using: :btree
  add_index "dashboard_widgets", ["widget_id"], name: "index_dashboard_widgets_on_widget_id", using: :btree

  create_table "dashboards", force: true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id",                              array: true
    t.boolean  "guide_on",   default: true
    t.integer  "guide_step", default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "events", force: true do |t|
    t.json     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guides", force: true do |t|
    t.string   "title"
    t.integer  "step"
    t.string   "level"
    t.integer  "next_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_statuses", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_moderable", default: false
    t.boolean  "is_closed",    default: false
  end

  create_table "tickets", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "ticket_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.boolean  "is_admin",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 128,                 null: false
    t.string   "encrypted_password",     limit: 128
    t.string   "reset_password_token",   limit: 256
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 128
    t.string   "last_sign_in_ip",        limit: 128
    t.boolean  "is_moderator",                       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "widget_rules", force: true do |t|
    t.integer  "controlled_id"
    t.string   "controlled_type"
    t.boolean  "allow",           default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "widget_rules", ["controlled_id", "controlled_type"], name: "index_widget_rules_on_controlled_id_and_controlled_type", using: :btree

  create_table "widget_rules_widgets", id: false, force: true do |t|
    t.integer "widget_id"
    t.integer "widget_rule_id"
  end

  add_index "widget_rules_widgets", ["widget_id"], name: "index_widgets_widget_rules_on_widgets_id", using: :btree
  add_index "widget_rules_widgets", ["widget_rule_id"], name: "index_widgets_widget_rules_on_widget_rules_id", using: :btree

  create_table "widgets", force: true do |t|
    t.string   "name"
    t.integer  "template_id"
    t.integer  "user_id"
    t.boolean  "is_admited",   default: false
    t.boolean  "is_moderable", default: false
    t.boolean  "is_template",  default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_readonly",  default: true
  end

  add_index "widgets", ["template_id"], name: "index_widgets_on_template_id", using: :btree

end
