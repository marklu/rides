class Arrangement < ActiveRecord::Base
  has_one :destination, :as => :locatable, :class_name => "Location"
  belongs_to :driver, :class_name => "Person", :foreign_key => "driver_id"
  has_one :origin, :as => :locatable, :class_name => "Location"
  has_and_belongs_to_many :passengers, :class_name => "Person",
    :join_table => "arrangements_passengers", :association_foreign_key => "passenger_id"
  belongs_to :trip
  belongs_to :vehicle

  def capacity
    self.vehicle.capacity - 1
  end

  def full?
    self.passengers.count >= self.vehicle.capacity
  end
end
