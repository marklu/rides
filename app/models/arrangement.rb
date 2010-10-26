class Arrangement < ActiveRecord::Base
  belongs_to :driver, :class_name => "Person", :foreign_key => "driver_id"
  has_and_belongs_to_many :passengers, :class_name => "Person",
    :join_table => "arrangements_passengers", :association_foreign_key => "passenger_id"
  belongs_to :trip
  belongs_to :vehicle
end
