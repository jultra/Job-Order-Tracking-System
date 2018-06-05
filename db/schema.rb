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

ActiveRecord::Schema.define(version: 20180531134549) do

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

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "position"
    t.string "fname"
    t.string "mname"
    t.string "lname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
