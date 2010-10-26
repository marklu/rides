class Person < ActiveRecord::Base
  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_many :trips, :foreign_key => "organizer_id"
  has_and_belongs_to_many :trips, :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :vehicles, :foreign_key => "owner_id"
end
