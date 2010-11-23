class Invitation < ActiveRecord::Base

  #Add field for email, for the case when we're inviting non-registered users!

  belongs_to :pending_trip, :class_name => "Trip", :foreign_key => :pending_trip_id


  belongs_to :invitee, :class_name => "Person", :foreign_key => :invitee_id
  validates_uniqueness_of :pending_trip_id, :scope => :invitee_id, :message => 'Error: Invitation already exists.'

  attr_accessible :email
end
