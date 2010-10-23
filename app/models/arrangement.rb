class Arrangement < ActiveRecord::Base
  belongs_to :trip
  belongs_to :driver, :class_name => "person"
  has_many :people # Passengers
  has_one :vehicle
end