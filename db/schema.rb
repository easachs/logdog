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

ActiveRecord::Schema[8.0].define(version: 2025_09_25_211226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "equipment"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weightlogs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "weight"
    t.datetime "logged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weightlogs_on_user_id"
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.text "notes"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_sets", force: :cascade do |t|
    t.bigint "workout_exercise_id", null: false
    t.integer "set_number"
    t.integer "reps"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workout_exercise_id"], name: "index_workout_sets_on_workout_exercise_id"
  end

  create_table "workout_template_exercises", force: :cascade do |t|
    t.bigint "workout_template_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "order", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_template_exercises_on_exercise_id"
    t.index ["workout_template_id", "order"], name: "idx_on_workout_template_id_order_6687cd9501"
    t.index ["workout_template_id"], name: "index_workout_template_exercises_on_workout_template_id"
  end

  create_table "workout_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "notes"
    t.datetime "performed_at"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "weightlogs", "users"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workout_sets", "workout_exercises"
  add_foreign_key "workout_template_exercises", "exercises"
  add_foreign_key "workout_template_exercises", "workout_templates"
  add_foreign_key "workouts", "users"
end
