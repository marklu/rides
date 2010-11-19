class Invitation < ActiveRecord::Base
  belongs_to :pending_trip, :class_name => "Trip", :foreign_key => :pending_trip_id
  belongs_to :invitee, :class_name => "Person", :foreign_key => :invitee_id
end
