class Vehicle < ActiveRecord::Base
  validates :make, :presence => true
  validates :model, :presence => true
  validates :capacity,
    :presence => true,
    :numericality => {:only_integer => true, :greater_than => 0}
  validates :owner, :presence => true

  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"

  def passenger_capacity
    self.capacity - 1
  end
end
