class Location < ActiveRecord::Base
  validates :address, :presence => true, :location => true

  belongs_to :locatable, :polymorphic => true

  geocoded_by :address
  after_validation :fetch_coordinates

  def distance_to(other)
    Geocoder.distance_between(self.latitude, self.longitude, other.latitude, other.longitude)
  end
end
