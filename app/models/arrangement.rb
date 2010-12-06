class Arrangement < ActiveRecord::Base
  validates :vehicle, :presence => true
  validates :trip, :presence => true
  validates :origin, :presence => true
  validates :destination, :presence => true

  has_and_belongs_to_many :passengers, :class_name => "Person",
    :join_table => "arrangements_passengers", :association_foreign_key => "passenger_id"
  belongs_to :vehicle
  belongs_to :trip
  belongs_to :origin, :class_name => "Location", :dependent => :destroy
  belongs_to :destination, :class_name => "Location", :dependent => :destroy

  def driver
    self.vehicle.owner
  end

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
