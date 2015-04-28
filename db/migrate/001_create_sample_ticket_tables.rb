class CreateSampleTicketTables < ActiveRecord::Migration
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql" 
  def self.up
    
    create_table "categories", primary_key: "category_id", force: true do |t|
      t.string   "name",       limit: nil,                   null: false
      t.datetime "created_at",             default: "now()"
      t.datetime "updated_at"
    end

    create_table "ticket_statuses", primary_key: "ticket_status_id", force: true do |t|
      t.string   "name",       limit: nil,                   null: false
      t.integer  "position"
      t.datetime "created_at",             default: "now()"
      t.datetime "updated_at"
    end

    create_table "tickets", primary_key: "ticket_id", force: true do |t|
      t.string   "title",            limit: nil
      t.text     "description"
      t.integer  "user_id"
      t.integer  "category_id"
      t.integer  "ticket_status_id"
      t.datetime "created_at",                   default: "now()"
      t.datetime "updated_at"
    end

    create_table "users", primary_key: "user_id", force: true do |t|
      t.string   "name",                   limit: 128,                   null: false
      t.boolean  "is_admin",                           default: false
      t.datetime "created_at",                         default: "now()"
      t.datetime "updated_at"
      t.string   "email",                  limit: 128,                   null: false
      t.string   "encrypted_password",     limit: 128
      t.string   "reset_password_token",   limit: 256
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count"
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip",     limit: 128
      t.string   "last_sign_in_ip",        limit: 128
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  def self.down
    drop_table "categories"
    drop_table "ticket_statuses"
    drop_table "tickets"
    drop_table "users"
  end
end