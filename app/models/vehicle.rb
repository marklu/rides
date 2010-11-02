class Vehicle < ActiveRecord::Base
  validates_presence_of :owner_id
  validates_presence_of :make
  validates_presence_of :model
  validates_presence_of :capacity
  validates_numericality_of :capacity, :only_integer => true, :greater_than => 0

  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
end
