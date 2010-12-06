class Trip < ActiveRecord::Base
  after_initialize :initialize_nested_attributes

  validates :name, :presence => true
  validates :time, :presence => true, :timeliness => {:type => :datetime}
  validates :location, :existence => true
  validates :organizer, :existence => true

  has_many :arrangements, :dependent => :destroy
  belongs_to :location, :dependent => :destroy
  belongs_to :organizer, :class_name => "Person", :foreign_key => "organizer_id"
  has_and_belongs_to_many :participants, :class_name => "Person",
    :join_table => "participants_trips", :association_foreign_key => "participant_id"
  has_many :invitations, :dependent => :destroy
  has_and_belongs_to_many :vehicles

  accepts_nested_attributes_for :location

  def arrangement_for(person)
    return self.arrangements.select { |arrangement| arrangement.passengers.include?(person) }.first
  end

  def invitees
    self.invitations.map do |invitation|
      {:email => invitation.email}
    end
  end

  def upcoming?
    return self.time >= Time.now()
  end

  def initialize_nested_attributes
    self.location ||= self.build_location
  end
end
