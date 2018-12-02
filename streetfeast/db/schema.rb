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

ActiveRecord::Schema.define(version: 20180620111932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.text     "address_line"
    t.integer  "restaurant_id"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "is_reviewed"
    t.boolean  "is_blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "fullname"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "rating"
    t.text     "description"
    t.string   "viewers_ip"
    t.string   "viewers_city"
    t.string   "viewers_region"
    t.string   "viewers_country"
    t.string   "viewers_continent"
    t.string   "viewers_latitude"
    t.string   "viewers_longitude"
    t.string   "viewers_internet_service_provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_types", force: true do |t|
    t.string   "issue_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "picture_id"
    t.integer  "user_id"
    t.boolean  "is_liked",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "item_name"
    t.integer  "price"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_available",  default: true
  end

  create_table "pictures", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
  end

  create_table "restaurants", force: true do |t|
    t.string   "associated_blogs"
    t.string   "name"
    t.text     "description"
    t.string   "operator"
    t.string   "opening_time"
    t.string   "closing_time"
    t.boolean  "is_blacklisted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "closed_on"
    t.string   "contact_number"
    t.string   "cuisine"
    t.integer  "cost_for_two"
    t.boolean  "is_deactive",      default: false
  end

  create_table "subscriptions", force: true do |t|
    t.string   "user_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "support_tickets", force: true do |t|
    t.integer  "user_id"
    t.text     "issue_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_resolved",       default: false
    t.integer  "issue_type_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "mobile_no"
    t.string   "city"
    t.boolean  "is_blocked",             default: false
    t.boolean  "is_admin"
    t.string   "state"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "sign_in_type",           default: ""
    t.string   "fullname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
