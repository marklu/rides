class Trip < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_many :vehicles
  has_many :arrangements
  has_one :organizer, :class_name => 'person'
end
