# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_30_165831) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "category"
    t.text "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_articles_on_category"
    t.index ["tags"], name: "index_articles_on_tags", using: :gin
  end

  create_table "character_sheets", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.string "name"
    t.string "character_class"
    t.string "partial"
    t.string "species"
    t.string "gender"
    t.string "employer"
    t.string "homeworld"
    t.string "background"
    t.integer "level"
    t.string "xp"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "system_strain"
    t.string "system_strain_perm"
    t.string "hp_max"
    t.string "hp_curr"
    t.string "ab"
    t.string "st_phys"
    t.string "st_evade"
    t.string "st_ment"
    t.text "cyberware"
    t.string "credits"
    t.string "credits_owed"
    t.string "effort_curr"
    t.string "effort_max"
    t.string "skill_points"
    t.text "notes"
    t.text "jsondata"
    t.string "tags"
    t.json "weapons_json"
    t.json "armor_json"
    t.json "gear_json"
    t.json "skills_json"
    t.json "foci_json"
    t.json "psi_powers_json"
    t.json "goals_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "initiative"
    t.string "base_attack_bonus"
    t.string "full_attack_bonus"
    t.string "active_ac"
    t.index ["player_id"], name: "index_character_sheets_on_player_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "player_id", null: false
    t.json "roll_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["player_id"], name: "index_messages_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "character_sheets", "players"
  add_foreign_key "messages", "players"
end
