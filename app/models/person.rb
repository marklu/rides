class Person < ActiveRecord::Base
  after_initialize :initialize_nested_attributes
  after_validation :format_phone

  validates :name, :presence => true
  validates :phone, 
    :presence => true,
    :format => {
      :with => /^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
      :message => "is not a valid numeric US phone number"
    }
  validates :location, :presence => true

  has_and_belongs_to_many :arrangements,
    :join_table => "arrangements_passengers", :foreign_key => "passenger_id"
  belongs_to :location, :dependent => :destroy
  has_and_belongs_to_many :organized_trips, :class_name => "Trip",
    :join_table => "organizers_trips", :foreign_key => "organizer_id"
  has_one :preferences, :dependent => :destroy
  has_and_belongs_to_many :trips, :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :vehicles, :foreign_key => "owner_id", :dependent => :destroy

  accepts_nested_attributes_for :location, :preferences

  devise :database_authenticatable, :registerable, :validatable
  attr_accessible :email, :password, :password_confirmation, :name, :phone,
    :location, :location_attributes, :preferences, :preferences_attributes

  def incompatibility_with(other)
    self.preferences.incompatibility_with(other.preferences)
  end

  def upcoming_trips
    self.trips.select {|trip| trip.upcoming?}
  end

  def initialize_nested_attributes
    self.location ||= self.build_location
    self.preferences ||= self.build_preferences
  end

  def format_phone
    unless self.phone.nil?
      self.phone.gsub!(/^\(?\b([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '(\1) \2-\3')
    end
  end
end
