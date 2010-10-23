class Person < ActiveRecord::Base
  has_many :vehicles
  has_and_belongs_to_many :trips # One person can be part of multiple trips, and one trip has many participants
  belongs_to :arrangement # Passengers
  has_one :arrangement, :foreign_key => :driver_id
  has_one :trip, :foreign_key => :organizer_id
end
