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

ActiveRecord::Schema.define(:version => 20101023221347) do

  create_table "arrangements", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "driver_id"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", :force => true do |t|
    t.time     "time"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organizer_id"
  end

  create_table "vehicles", :force => true do |t|
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
