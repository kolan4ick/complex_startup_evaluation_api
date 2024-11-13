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

ActiveRecord::Schema[8.0].define(version: 2024_11_13_202240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "effectiveness_scores", force: :cascade do |t|
    t.float "value"
    t.integer "order"
    t.bigint "evaluation_id", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_effectiveness_scores_on_evaluation_id"
  end

  create_table "evaluation_scores_maxes", force: :cascade do |t|
    t.float "value"
    t.integer "order"
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_evaluation_scores_maxes_on_evaluation_id"
  end

  create_table "evaluation_scores_mins", force: :cascade do |t|
    t.float "value"
    t.integer "order"
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_evaluation_scores_mins_on_evaluation_id"
  end

  create_table "evaluation_scores_sums", force: :cascade do |t|
    t.float "value"
    t.integer "order"
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_evaluation_scores_sums_on_evaluation_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_stability"
    t.integer "team_competencies_and_experience"
    t.integer "team_leaders_competencies"
    t.integer "team_competencies"
    t.integer "team_professional_activity"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exp"], name: "index_jwt_denylists_on_exp"
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "risk_scores", force: :cascade do |t|
    t.string "linguistic"
    t.float "authenticity"
    t.string "type"
    t.bigint "evaluation_id", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_risk_scores_on_evaluation_id"
  end

  create_table "team_scores", force: :cascade do |t|
    t.string "linguistic"
    t.float "confidence"
    t.float "weight"
    t.integer "order"
    t.bigint "evaluation_id", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_team_scores_on_evaluation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "effectiveness_scores", "evaluations"
  add_foreign_key "evaluation_scores_maxes", "evaluations"
  add_foreign_key "evaluation_scores_mins", "evaluations"
  add_foreign_key "evaluation_scores_sums", "evaluations"
  add_foreign_key "evaluations", "users"
  add_foreign_key "risk_scores", "evaluations"
  add_foreign_key "team_scores", "evaluations"
end
