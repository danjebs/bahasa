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

ActiveRecord::Schema[7.1].define(version: 2024_05_12_045240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "deck_card_outcome", ["none", "hint", "flash"]
  create_enum "deck_card_status", ["created", "attempted", "completed"]
  create_enum "deck_status", ["created", "started", "completed"]
  create_enum "step_status", ["created", "started", "completed"]
  create_enum "user_role", ["student", "teacher", "admin"]

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "card_proficiencies", force: :cascade do |t|
    t.bigint "journey_id", null: false
    t.bigint "card_id", null: false
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_proficiencies_on_card_id"
    t.index ["journey_id"], name: "index_card_proficiencies_on_journey_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "type"
    t.string "front"
    t.string "back"
    t.integer "position"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_cards_on_lesson_id"
  end

  create_table "deck_cards", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "card_id", null: false
    t.integer "position"
    t.integer "time_taken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "deck_card_status"
    t.enum "outcome", enum_type: "deck_card_outcome"
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.bigint "journey_id", null: false
    t.integer "difficulty"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "deck_status"
    t.index ["journey_id"], name: "index_decks_on_journey_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "title"
    t.string "type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_exercises_on_lesson_id"
  end

  create_table "journeys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_journeys_on_language_id"
    t.index ["user_id"], name: "index_journeys_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "slug", default: "", null: false
    t.bigint "language_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_lessons_on_language_id"
  end

  create_table "phrases", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.string "phrase"
    t.string "translation"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_phrases_on_exercise_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "journey_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "step_status"
    t.index ["journey_id"], name: "index_steps_on_journey_id"
    t.index ["lesson_id"], name: "index_steps_on_lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "role", enum_type: "user_role"
    t.bigint "default_language_id"
    t.index ["default_language_id"], name: "index_users_on_default_language_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.string "word"
    t.string "translation"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_words_on_exercise_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_proficiencies", "cards"
  add_foreign_key "card_proficiencies", "journeys"
  add_foreign_key "cards", "lessons"
  add_foreign_key "deck_cards", "cards"
  add_foreign_key "deck_cards", "decks"
  add_foreign_key "decks", "journeys"
  add_foreign_key "exercises", "lessons"
  add_foreign_key "journeys", "languages"
  add_foreign_key "journeys", "users"
  add_foreign_key "lessons", "languages"
  add_foreign_key "phrases", "exercises"
  add_foreign_key "steps", "journeys"
  add_foreign_key "steps", "lessons"
  add_foreign_key "users", "languages", column: "default_language_id"
  add_foreign_key "words", "exercises"
end
