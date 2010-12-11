class Invitation < ActiveRecord::Base
  before_validation(:on => :create) {generate_token}
  after_save :send_invitation

  validates :invitee, :presence => true
  validates :email,
    :presence => true,
    :format => {:with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i},
    :not_participant => true,
    :uniqueness => {:scope => :trip_id, :message => ' already has an invitation.'}
  validates :role,
    :inclusion => {
      :in => ['participant', 'organizer'],
      :message => "must be one of Participant or Organizer"
    }
  validates :inviter, :presence => true
  validates :token, :presence => true, :uniqueness => true
  validates :trip, :presence => true

  belongs_to :trip

  def generate_token
   token = Digest::MD5.hexdigest(self.email + self.trip.id.to_s)
   while !Invitation.find_by_token(token).nil?
     token.next!
    end
    self.token = token
  end

  def send_invitation
    InvitationMailer.invitation(self).deliver
  end

  def accept(person)
    self.trip.participants << person
    self.trip.organizers << person if self.role == 'organizer'
    self.destroy
  end
end
