class CreateSampleTicketTables < ActiveRecord::Migration
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql" 
  def self.up
    
    create_table "categories", force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "ticket_statuses", force: true do |t|
      t.string   "name"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
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