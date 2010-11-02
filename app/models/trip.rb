class Trip < ActiveRecord::Base
  has_many :arrangements
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_and_belongs_to_many :vehicles

  validates_presence_of :name
  validates_presence_of :time
  validates_datetime :time
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  
  def upcoming?
    return self.time >= Time.now()
  end
  
  def arrangement_for(person)
    return arrangements.select { |arrangement| arrangement.passengers.include?(person) }.first
  end

  def self.upcoming_for(person)
    return self.find(:all).select { |trip| trip.upcoming? && trip.participants.include?(person) }
  end

  def self.organized_by(person)
    return self.find(:all, :conditions => ["organizer_id = ?", person.id ])
  end

end
