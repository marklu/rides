class Trip < ActiveRecord::Base
  validates :name, :presence => true
  validates :time, :presence => true, :timeliness => {:type => :datetime}
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :organizer, :existence => {:allow_nil => false}

  has_many :arrangements
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_and_belongs_to_many :invitees, :class_name => "Person",
    :join_table => "invitees_trips", :association_foreign_key => "invitee_id"
  has_and_belongs_to_many :vehicles
  
  def arrangement_for(person)
    return arrangements.select {|arrangement| arrangement.passengers.include?(person)}.first
  end

  def organized_by?(person)
    return self.organizer == person
  end

  def upcoming?
    return self.time >= Time.now()
  end
end
