class Person < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :phone

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :name, :phone,
    :address, :city, :state, :music, :smoking

  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_many :trips, :foreign_key => "organizer_id"
  has_and_belongs_to_many :trips, :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :vehicles, :foreign_key => "owner_id"
end