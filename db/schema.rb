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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "advancement_requirement"
    t.integer "agenda_points"
    t.integer "base_link"
    t.text "code", null: false
    t.integer "cost"
    t.integer "deck_limit"
    t.integer "faction_id"
    t.integer "influence_cost"
    t.integer "influence_limit"
    t.integer "memory_cost"
    t.integer "minimum_deck_size"
    t.text "name", null: false
    t.integer "side_id"
    t.integer "strength"
    t.text "text"
    t.integer "trash_cost"
    t.integer "type_id"
    t.boolean "uniqueness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faction_id"], name: "index_cards_on_faction_id"
    t.index ["side_id"], name: "index_cards_on_side_id"
    t.index ["type_id"], name: "index_cards_on_type_id"
  end

  create_table "cards_subtypes", id: false, force: :cascade do |t|
    t.uuid "card_id", null: false
    t.integer "subtype_id", null: false
    t.index ["subtype_id"], name: "index_cards_subtypes_on_subtype_id"
  end

  create_table "factions", force: :cascade do |t|
    t.text "code", null: false
    t.boolean "is_mini", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sides", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtypes", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
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

  add_foreign_key "cards", "factions"
  add_foreign_key "cards", "sides"
  add_foreign_key "cards", "types"
end
