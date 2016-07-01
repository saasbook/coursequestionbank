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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160430062346) do

  create_table "collections", :force => true do |t|
    t.integer  "instructor_id"
    t.string   "name"
    t.datetime "last_used"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "description"
    t.boolean  "is_public"
    t.string   "color"
  end

  create_table "collections_problems", :id => false, :force => true do |t|
    t.integer "collection_id"
    t.integer "problem_id"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "current_collection"
    t.string   "provider_image"
    t.string   "provider_email"
    t.string   "username"
  end

  create_table "problems", :force => true do |t|
    t.integer  "instructor_id"
    t.text     "text"
    t.datetime "created_date"
    t.string   "created_by"
    t.boolean  "is_public"
    t.datetime "last_used"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "rendered_text"
    t.string   "problem_type"
    t.text     "json"
    t.integer  "previous_version_id"
    t.string   "bloom_category"
    t.boolean  "obsolete"
    t.string   "uid"
  end

  create_table "problems_tags", :id => false, :force => true do |t|
    t.integer "problem_id"
    t.integer "tag_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "whitelists", :force => true do |t|
    t.string   "username"
    t.string   "privilege"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "provider",   :default => "github"
  end

end
