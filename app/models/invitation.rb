class Invitation < ActiveRecord::Base
  #Add field for email, for the case when we're inviting non-registered users!
  belongs_to :pending_trip, :class_name => "Trip"
#  belongs_to :invitee, :class_name => "Person"
  validates_uniqueness_of :pending_trip_id, :scope => :email, :message => 'Error: Invitation already exists.'

  attr_accessible :email
end
