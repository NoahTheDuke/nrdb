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

ActiveRecord::Schema.define(version: 20190403210706) do

  create_table "cards", force: :cascade do |t|
    t.integer "advancement_requirement"
    t.integer "agenda_points"
    t.integer "base_link"
    t.integer "cost"
    t.integer "deck_limit"
    t.text "faction", null: false
    t.integer "influence_cost"
    t.integer "influence_limit"
    t.integer "memory_cost"
    t.integer "minimum_deck_size"
    t.text "side"
    t.integer "strength"
    t.text "subtype"
    t.text "text"
    t.text "title", null: false
    t.integer "trash_cost"
    t.text "type", null: false
    t.boolean "uniqueness", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
