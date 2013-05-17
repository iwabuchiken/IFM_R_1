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

ActiveRecord::Schema.define(:version => 20130517033034) do

  create_table "images", :force => true do |t|
    t.string   "file_name"
    t.string   "file_path"
    t.text     "memos"
    t.string   "tags"
    t.string   "table_name"
    t.integer  "last_viewed_at"
    t.integer  "created_at_mill"
    t.integer  "updated_at_mill"
    t.integer  "date_added"
    t.integer  "date_modified"
    t.integer  "loc_file_id"
    t.integer  "loc_created_at"
    t.integer  "loc_modified_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
