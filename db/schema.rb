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

ActiveRecord::Schema.define(version: 20160107231514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attribute_maps", force: :cascade do |t|
    t.string   "record_type",                 null: false
    t.string   "field",                       null: false
    t.string   "label",                       null: false
    t.string   "key",                         null: false
    t.string   "nested_key",                  null: false
    t.string   "with"
    t.boolean  "searchable",  default: false
    t.boolean  "viewable",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "collection_objects", force: :cascade do |t|
    t.string   "object_number",                                     null: false
    t.string   "object_name"
    t.string   "responsible_department"
    t.string   "title"
    t.string   "title_type"
    t.date     "display_date"
    t.text     "brief_description"
    t.string   "content_persons",                      default: [],              array: true
    t.string   "content_concepts",                     default: [],              array: true
    t.text     "physical_description"
    t.text     "dimension_summary"
    t.string   "material_group",                       default: [],              array: true
    t.string   "technique_group",                      default: [],              array: true
    t.string   "object_production_organization_group", default: [],              array: true
    t.string   "object_production_people_group",       default: [],              array: true
    t.string   "object_production_person_group",       default: [],              array: true
    t.string   "ref_name",                                          null: false
    t.string   "uri",                                               null: false
    t.string   "origin_created_by"
    t.string   "origin_created_at",                                 null: false
    t.string   "origin_updated_at",                                 null: false
    t.string   "blob_url"
    t.string   "slug"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "subject_csid", null: false
    t.string   "subject_type", null: false
    t.string   "subject_uri",  null: false
    t.string   "object_csid",  null: false
    t.string   "object_type",  null: false
    t.string   "object_uri",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
