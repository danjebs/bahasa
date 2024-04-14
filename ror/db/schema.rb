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

ActiveRecord::Schema[7.1].define(version: 2024_04_14_032646) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["student", "teacher", "admin"]

  create_table "exercises", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "title"
    t.string "type"
    t.integer "position"
    t.bigint "wordlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_exercises_on_lesson_id"
    t.index ["wordlist_id"], name: "index_exercises_on_wordlist_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_wordlists", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "wordlist_id", null: false
    t.integer "postion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_wordlists_on_lesson_id"
    t.index ["wordlist_id"], name: "index_lesson_wordlists_on_wordlist_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wordlists", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_wordlists_on_language_id"
  end

  add_foreign_key "exercises", "lessons"
  add_foreign_key "exercises", "wordlists"
  add_foreign_key "lesson_wordlists", "lessons"
  add_foreign_key "lesson_wordlists", "wordlists"
  add_foreign_key "lessons", "languages"
  add_foreign_key "wordlists", "languages"
end
