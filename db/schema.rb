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

ActiveRecord::Schema.define(version: 20160105212554) do

  create_table "hanterships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "hant_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hanterships", ["hant_id"], name: "index_hanterships_on_hant_id"
  add_index "hanterships", ["user_id", "hant_id", "type"], name: "index_hanterships_on_user_id_and_hant_id_and_type", unique: true
  add_index "hanterships", ["user_id"], name: "index_hanterships_on_user_id"

  create_table "hants", force: :cascade do |t|
    t.string   "one_phrase"
    t.string   "content"
    t.integer  "study_evaluation", default: 0, null: false
    t.integer  "pc_evaluation",    default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "space_id"
    t.integer  "user_id"
  end

  add_index "hants", ["space_id", "user_id"], name: "index_hants_on_space_id_and_user_id", unique: true

  create_table "spaces", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "spaces", ["latitude", "longitude"], name: "index_spaces_on_latitude_and_longitude", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "profile"
    t.string   "hometown"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
