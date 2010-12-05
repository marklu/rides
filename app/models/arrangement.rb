class Arrangement < ActiveRecord::Base
  validates :driver, :existence => true
  validates :trip, :existence => true
  validates :vehicle, :existence => true

  has_one :destination, :as => :locatable, :class_name => "Location"
  belongs_to :driver, :class_name => "Person", :foreign_key => "driver_id"
  has_one :origin, :as => :locatable, :class_name => "Location"
  has_and_belongs_to_many :passengers, :class_name => "Person",
    :join_table => "arrangements_passengers", :association_foreign_key => "passenger_id"
  belongs_to :trip
  belongs_to :vehicle

  def preferences
    self.driver.nil? ? Preferences.new : self.driver.preferences
  end

  def capacity
    self.vehicle.passenger_capacity
  end

  def full?
    self.passengers.count >= self.vehicle.passenger_capacity
  end

  def incompatibility_with(other)
    self.preferences.incompatibility_with(other.preferences)
  end
end
