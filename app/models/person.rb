class Person < ActiveRecord::Base
  # Set default preferences
  before_validation do
    self.music ||= 'no_preference'
    self.smoking ||= 'no_preference'
  end

  validates :name, :presence => true, :unless => Proc.new {|name| self.name.nil?}
  validates :phone, :presence => true,
    :format => {:with => /^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
    :message => "must be a complete and numeric US phone number"},
    :unless => Proc.new {|phone| self.phone.nil?}
  validates :password, :presence => true, :unless => Proc.new {|password| self.password.nil?}
  validates :address, :presence => true, :mailing_address => true, :allow_nil => true
  validates :music, :inclusion => {:in => ['no_preference', 'no_music', 'quiet_music', 'loud_music'],
    :message => "must be one of No Preference, No Music, Quiet Music, or Loud Music"}#, :allow_nil => true
  validates :smoking, :inclusion => {:in => ['no_preference', 'no_smoking', 'smoking'],
    :message => "must be one of No Preference, No Smoking, or Smoking"}#, :allow_nil => true

  # Process phone numbers
  after_validation do
    self.phone.gsub!(/^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '(\1) \2-\3') unless self.phone.nil?
  end 

  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_many :organized_trips, :class_name => "Trip", :foreign_key => "organizer_id"
  has_and_belongs_to_many :trips, :class_name => "Trip", :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :invitations
#  has_many :pending_trips, :through => :invitations
  has_many :vehicles, :foreign_key => "owner_id"

  devise :database_authenticatable, :registerable, :validatable
  attr_accessible :email, :password, :password_confirmation, :name, :phone,
    :address, :city, :state, :music, :smoking

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
