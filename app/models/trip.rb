class Trip < ActiveRecord::Base
  has_many :arrangements
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_and_belongs_to_many :vehicles

  def upcoming?
    return time >= Time.now
  end
  
  def self.upcoming_for(user)
    return self.find(:all).select { |trip| trip.upcoming? && trip.participants.include?(user) }
  end
end
