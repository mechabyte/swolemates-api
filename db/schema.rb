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

ActiveRecord::Schema.define(version: 20151006210400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_steps", force: :cascade do |t|
    t.text    "description"
    t.integer "row_order"
    t.integer "exercise_id"
  end

  add_index "exercise_steps", ["exercise_id"], name: "index_exercise_steps_on_exercise_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "muscle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "exercises", ["muscle_id"], name: "index_exercises_on_muscle_id", using: :btree

  create_table "muscles", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "exercises_count", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                               null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_name",                      default: "",        null: false
    t.string   "last_name",                       default: "",        null: false
    t.string   "username",                        default: "",        null: false
    t.string   "role",                            default: "default", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "exercise_steps", "exercises"
  add_foreign_key "exercises", "muscles"
end
