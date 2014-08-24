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

ActiveRecord::Schema.define(version: 20140824150512) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "steam_app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "game_id"
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["game_id"], name: "index_posts_on_game_id"

  create_table "posts_users", force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "posts_users", ["post_id"], name: "index_posts_users_on_post_id"
  add_index "posts_users", ["user_id"], name: "index_posts_users_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username",            default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nick"
    t.boolean  "admin"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
