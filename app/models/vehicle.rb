class Vehicle < ActiveRecord::Base
  belongs_to :person # Owner of the vehicle
  belongs_to :arrangement
end
