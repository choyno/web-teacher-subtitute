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

ActiveRecord::Schema.define(:version => 20121016184446) do

  create_table "day_codes", :force => true do |t|
    t.string "name", :limit => 20
  end

  create_table "departments", :force => true do |t|
    t.string "name", :limit => 120
  end

  create_table "reasons", :force => true do |t|
    t.string "name", :limit => 20
  end

  create_table "rooms", :force => true do |t|
    t.string   "name",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "schedule_files", :force => true do |t|
    t.string   "excel_file", :limit => 150
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "name",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string "name", :limit => 100
  end

  create_table "subject_types", :force => true do |t|
    t.string   "name",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "code",       :limit => 20
    t.string   "name"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "substitute_details", :force => true do |t|
    t.integer  "substitute_teacher_id"
    t.integer  "reasons_id"
    t.integer  "teacher_subject_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "substitute_id"
  end

  create_table "substitute_reports", :force => true do |t|
    t.integer "substitute_id"
    t.integer "teacher_id"
    t.integer "teacher_substitute_id"
    t.integer "teacher_subject_id"
    t.float   "total_hours"
    t.date    "date_applied"
  end

  create_table "substitutes", :force => true do |t|
    t.integer  "substitute_teacher_id"
    t.integer  "reason_id"
    t.text     "notes"
>>>>>>> 99dc44fbd6b68298274b62edfc8661cabc96399d
>>>>>>> 7c1de44b1dfa41650c49eea9ae68c5d70be1c983
    t.integer  "teacher_subject_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "substitute_id"
  end

  create_table "substitute_reports", :force => true do |t|
    t.integer "substitute_id"
    t.integer "teacher_id"
    t.integer "teacher_substitute_id"
    t.integer "teacher_subject_id"
    t.float   "total_hours"
    t.date    "date_applied"
  end

  create_table "substitutes", :force => true do |t|
    t.text     "notes"
    t.boolean  "planned",               :default => false
    t.string   "status"
    t.datetime "requested_at"
    t.datetime "approved_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.date     "request_at_from"
    t.date     "request_at_to"
    t.integer  "teacher_id"
    t.date     "start_requested_at"
    t.date     "end_requested_at"
    t.integer  "substitute_details_id"
    t.date     "request_at_from"
    t.date     "request_at_to"
    t.integer  "teacher_id"
    t.integer  "reason_id"
    t.integer  "assigned_by_user_id"
    t.date     "request_at_from"
    t.date     "request_at_to"
    t.integer  "teacher_id"
  end

  create_table "teacher_availabilities", :force => true do |t|
    t.integer "teacher_id"
    t.string  "day",              :limit => 2
    t.integer "time_schedule_id"
  end

  create_table "teacher_schedules", :force => true do |t|
    t.string  "day",                :limit => 5
    t.integer "teacher_subject_id"
    t.integer "time_schedule_id"
  end

  create_table "teacher_subjects", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.time     "time_end"
    t.string   "room_id"
    t.integer  "day_code_id"
    t.integer  "section_id"
    t.integer  "subject_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.time     "time_start"
  end

  create_table "teachers", :force => true do |t|
    t.string   "firstname",    :limit => 20
    t.string   "lastname",     :limit => 20
    t.string   "phone_number", :limit => 20
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "time_schedules", :force => true do |t|
    t.string "time_range"
    t.time   "time_start"
    t.time   "time_end"
  end

  create_table "users", :force => true do |t|
    t.string   "full_name",     :limit => 120
    t.string   "username",      :limit => 120
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "department_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "user_type",     :limit => 50
    t.boolean  "status",                       :default => true
  end

end
