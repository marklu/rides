class Person < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable



  has_and_belongs_to_many :arrangements, :join_table => "arrangements_passengers",
    :foreign_key => "passenger_id"
  has_many :trips, :foreign_key => "organizer_id"
  has_and_belongs_to_many :trips, :join_table => "participants_trips",
    :foreign_key => "participant_id"
  has_many :vehicles, :foreign_key => "owner_id"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :phone, :address, :city, :state, :music, :smoking



end