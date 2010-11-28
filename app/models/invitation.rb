class Invitation < ActiveRecord::Base
  
  validates :email, :presence => true
  validates :token, :presence => true
  validates_uniqueness_of :email, :scope => :pending_trip_id, :message => ' already has an invitation.'
#  validates :pending_trip, :existence => true

  belongs_to :pending_trip, :class_name => "Trip", :foreign_key => "pending_trip_id"
 
  attr_accessible :email, :token
end
