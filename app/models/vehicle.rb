class Vehicle < ActiveRecord::Base
  validates_presence_of :capacity
  validates_presence_of :owner

  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
end
