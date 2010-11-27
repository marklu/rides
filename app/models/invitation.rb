class Invitation < ActiveRecord::Base
  #Add field for email, for the case when we're inviting non-registered users!
  belongs_to :pending_trip, :class_name => "Trip"
#  belongs_to :invitee, :class_name => "Person"
  validates :email, :presence => true
  validates_uniqueness_of :email, :scope => :pending_trip_id, :message => ' already has an invitation.'

  attr_accessible :email, :token
end
