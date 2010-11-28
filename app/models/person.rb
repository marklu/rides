class Person < ActiveRecord::Base
  before_validation do # Set default preferences
    self.music ||= 'no_preference'
    self.smoking ||= 'no_preference'
  end

  validates :name, :presence => true
  validates :phone, :presence => true,
    :format => {:with => /^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
                :message => "is not a valid numeric US phone number"}
  validates :location, :presence => true
  validates :music, :inclusion => {:in => ['no_preference', 'no_music', 'quiet_music', 'loud_music'],
    :message => "must be one of No Preference, No Music, Quiet Music, or Loud Music"}
  validates :smoking, :inclusion => {:in => ['no_preference', 'no_smoking', 'smoking'],
    :message => "must be one of No Preference, No Smoking, or Smoking"}

  after_initialize do # Initialize location for form helpers
    self.location ||= self.build_location
  end

  after_validation do # Process phone number
    self.phone.gsub!(/^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '(\1) \2-\3') unless self.phone.nil?
  end

  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_one :location, :as => :locatable
  accepts_nested_attributes_for :location
  has_many :organized_trips, :class_name => "Trip", :foreign_key => "organizer_id"
  has_and_belongs_to_many :trips, :class_name => "Trip", :join_table => "participants_trips",
    :foreign_key => "participant_id"
#  has_many :invitations
#  has_many :pending_trips, :through => :invitations
  has_many :vehicles, :foreign_key => "owner_id"

  devise :database_authenticatable, :registerable, :validatable
  attr_accessible :email, :password, :password_confirmation, :name, :phone,
    :location, :location_attributes, :music, :smoking

  def upcoming_trips
    self.trips.select {|trip| trip.upcoming?}
  end

  def pending_trips
    Invitation.find_all_by_email(self.email).map! {|invitation| invitation.pending_trip}
  end

  def invited_to?(trip)
    self.pending_trips.include?(trip)
  end

end
