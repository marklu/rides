class Vehicle < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
end
