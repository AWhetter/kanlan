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

ActiveRecord::Schema.define(version: 20130903192759) do

  create_table "games", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "game_id"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts_users", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "posts_users", ["post_id", "user_id"], name: "index_posts_users_on_post_id_and_user_id", unique: true

  create_table "rows", force: true do |t|
    t.integer  "table_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rows", ["table_group_id"], name: "index_rows_on_table_group_id"

  create_table "seats", force: true do |t|
    t.string   "name"
    t.integer  "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seats", ["table_id"], name: "index_seats_on_table_id"

  create_table "table_groups", force: true do |t|
    t.string   "name"
    t.integer  "left_end_table_id"
    t.integer  "right_end_table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "table_groups", ["left_end_table_id"], name: "index_table_groups_on_left_end_table_id"
  add_index "table_groups", ["right_end_table_id"], name: "index_table_groups_on_right_end_table_id"

  create_table "tables", force: true do |t|
    t.integer  "row_id"
    t.integer  "table_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tables", ["row_id"], name: "index_tables_on_row_id"
  add_index "tables", ["table_group_id"], name: "index_tables_on_table_group_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "ip"
    t.integer  "seat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["seat_id"], name: "index_users_on_seat_id"

end
