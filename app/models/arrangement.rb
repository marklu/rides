class Arrangement < ActiveRecord::Base
  validates :driver, :existence => true
  validates :vehicle, :existence => true
  validates :trip, :existence => true
  validates :origin, :existence => true
  validates :destination, :existence => true

  belongs_to :driver, :class_name => "Person", :foreign_key => "driver_id"
  has_and_belongs_to_many :passengers, :class_name => "Person",
    :join_table => "arrangements_passengers", :association_foreign_key => "passenger_id"
  belongs_to :vehicle
  belongs_to :trip
  belongs_to :origin, :class_name => "Location", :dependent => :destroy
  belongs_to :destination, :class_name => "Location", :dependent => :destroy

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
