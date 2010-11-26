class Location < ActiveRecord::Base
  validates :location, :presence => true, :location => true

  belongs_to :locatable, :polymorphic => true

  geocoded_by :location
  after_validation :fetch_coordinates

  def distance_to(other)
    Geocoder.distance_between(self.latitude, self.longitude, other.latitude, other.longitude)
  end
end
