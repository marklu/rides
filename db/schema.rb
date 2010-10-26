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

ActiveRecord::Schema.define(:version => 20101026043531) do

  create_table "arrangements", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "driver_id"
    t.integer  "trip_id"
    t.integer  "vehicle_id"
  end

  add_index "arrangements", ["trip_id"], :name => "index_arrangements_on_trip_id"
  add_index "arrangements", ["vehicle_id"], :name => "index_arrangements_on_vehicle_id"

  create_table "arrangements_passengers", :id => false, :force => true do |t|
    t.integer "arrangement_id", :null => false
    t.integer "passenger_id",   :null => false
  end

  add_index "arrangements_passengers", ["arrangement_id", "passenger_id"], :name => "index_arrangements_passengers_on_arrangement_id_and_passenger_id", :unique => true

  create_table "participants_trips", :id => false, :force => true do |t|
    t.integer "participant_id", :null => false
    t.integer "trip_id",        :null => false
  end

  add_index "participants_trips", ["participant_id", "trip_id"], :name => "index_participants_trips_on_participant_id_and_trip_id", :unique => true

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

  create_table "trips_vehicles", :id => false, :force => true do |t|
    t.integer "trip_id",    :null => false
    t.integer "vehicle_id", :null => false
  end

  add_index "trips_vehicles", ["trip_id", "vehicle_id"], :name => "index_trips_vehicles_on_trip_id_and_vehicle_id", :unique => true

  create_table "vehicles", :force => true do |t|
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "vehicles", ["owner_id"], :name => "index_vehicles_on_owner_id"

end
