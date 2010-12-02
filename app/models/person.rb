class Person < ActiveRecord::Base
  after_initialize do # Initialize nested attributes
    self.location ||= self.build_location
    self.preferences ||= self.build_preferences
  end

  validates :name, :presence => true
  validates :phone, :presence => true,
    :format => {:with => /^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
                :message => "is not a valid numeric US phone number"}
  validates :location, :presence => true

  after_validation do # Process phone number
    self.phone.gsub!(/^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '(\1) \2-\3') unless self.phone.nil?
  end

  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_one :location, :as => :locatable
  has_many :organized_trips, :class_name => "Trip", :foreign_key => "organizer_id"
  has_one :preferences
  has_and_belongs_to_many :trips, :class_name => "Trip", :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :vehicles, :foreign_key => "owner_id"

  accepts_nested_attributes_for :location, :preferences

  devise :database_authenticatable, :registerable, :validatable
  attr_accessible :email, :password, :password_confirmation, :name, :phone,
    :location, :location_attributes, :preferences, :preferences_attributes

  def incompatibility_with(other)
    self.preferences.incompatibility_with(other.preferences)
  end

  def invited_to?(trip)
    self.pending_trips.include?(trip)
  end

  def pending_trips
    Invitation.find_all_by_email(self.email).map! {|invitation| invitation.pending_trip}
  end

  def upcoming_trips
    self.trips.select {|trip| trip.upcoming?}
  end
end
