class Vehicle < ActiveRecord::Base
  validates :make, :presence => true
  validates :model, :presence => true
  validates :capacity, :presence => true,
    :numericality => {:only_integer => true, :greater_than => 0}
  validates :owner, :existence => {:allow_nil => false}

  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
end
