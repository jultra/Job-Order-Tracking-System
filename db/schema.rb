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

ActiveRecord::Schema.define(version: 20180521023454) do

  create_table "job_orders", force: :cascade do |t|
    t.string "control_no"
    t.string "job_type"
    t.string "code"
    t.text "information"
    t.string "where"
    t.string "requester"
    t.string "adviser"
    t.string "fund_source"
    t.string "signature"
    t.text "acknowledgment"
    t.string "job_office"
    t.string "inspected_by"
    t.text "remarks"
    t.string "available_materials"
    t.string "assigned_to"
    t.date "date_filed"
    t.date "date_needed"
    t.date "date_approved"
    t.date "delivery_date"
    t.time "time_needed"
    t.date "date_started"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "progress"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "position"
    t.string "fname"
    t.string "mname"
    t.string "lname"
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.boolean "active", default: true
    t.boolean "approved", default: true
    t.boolean "confirmed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["perishable_token"], name: "index_users_on_perishable_token", unique: true
    t.index ["persistence_token"], name: "index_users_on_persistence_token", unique: true
    t.index ["single_access_token"], name: "index_users_on_single_access_token", unique: true
  end

end
