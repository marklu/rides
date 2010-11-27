class Trip < ActiveRecord::Base
  validates :name, :presence => true
  validates :time, :presence => true, :timeliness => {:type => :datetime}
  validates :location, :presence => true
  validates :organizer, :existence => true

  has_many :arrangements
  has_one :location, :as => :locatable
  accepts_nested_attributes_for :location
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_many :invitations, :foreign_key => :pending_trip_id
  has_and_belongs_to_many :vehicles

  after_initialize do # Initialize location for form helpers
    self.location ||= self.build_location
  end
  
  def invitees
    self.invitations.map {|invitation| Person.find_by_email(invitation.email)}
  end

  def arrangement_for(person)
    return self.arrangements.select { |arrangement| arrangement.passengers.include?(person) }.first
  end

  def organized_by?(person)
    return self.organizer == person
  end

  def upcoming?
    return self.time >= Time.now()
  end

  def invite!(person)
    invitation = self.invitations.build(:email => person.email)
    return invitation
  end
end
