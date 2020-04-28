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

ActiveRecord::Schema.define(version: 20200428192026) do

  create_table "collections", force: :cascade do |t|
    t.integer  "instructor_id"
    t.string   "name",          limit: 255
    t.datetime "last_used"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "description"
    t.boolean  "is_public"
    t.string   "color",         limit: 255
    t.integer  "access_level",              default: 1
  end

  add_index "collections", ["instructor_id"], name: "index_collections_on_instructor_id"

  create_table "collections_problems", id: false, force: :cascade do |t|
    t.integer "collection_id"
    t.integer "problem_id"
  end

  add_index "collections_problems", ["collection_id"], name: "index_collections_problems_on_collection_id"
  add_index "collections_problems", ["problem_id"], name: "index_collections_problems_on_problem_id"

  create_table "instructors", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "provider",            limit: 255
    t.string   "uid",                 limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "current_collection"
    t.string   "provider_image",      limit: 255
    t.string   "provider_email",      limit: 255
    t.string   "username",            limit: 255
    t.string   "privilege",           limit: 255
    t.boolean  "uploaded_duplicates"
    t.boolean  "uploaded_same_file"
    t.boolean  "uploaded_empty_file"
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "instructor_id"
    t.text     "text"
    t.datetime "created_date"
    t.string   "created_by",          limit: 255
    t.boolean  "is_public"
    t.datetime "last_used"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "rendered_text"
    t.string   "problem_type",        limit: 255
    t.text     "json"
    t.integer  "previous_version_id"
    t.string   "bloom_category",      limit: 255
    t.boolean  "obsolete"
    t.string   "uid",                 limit: 255
    t.integer  "access_level",                    default: 1
  end

  add_index "problems", ["instructor_id"], name: "index_problems_on_instructor_id"
  add_index "problems", ["previous_version_id"], name: "index_problems_on_previous_version_id"

  create_table "problems_tags", id: false, force: :cascade do |t|
    t.integer "problem_id"
    t.integer "tag_id"
  end

  add_index "problems_tags", ["problem_id"], name: "index_problems_tags_on_problem_id"
  add_index "problems_tags", ["tag_id"], name: "index_problems_tags_on_tag_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255, null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "studentanswers", force: :cascade do |t|
    t.string   "attempt",       limit: 255
    t.boolean  "correctness"
    t.string   "problem_uid",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "instructor_id"
    t.integer  "problem_id"
    t.boolean  "first"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "whitelists", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "privilege",  limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "provider",   limit: 255, default: "github"
  end

end
