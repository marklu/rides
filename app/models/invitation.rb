class Invitation < ActiveRecord::Base
  validates :email, :presence => true, :format => {:with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i}, :not_participant => true, :uniqueness => {:scope => :trip_id, :message => ' already has an invitation.'}
  validates :token, :presence => true, :uniqueness => true
  validates :trip, :existence => true

  belongs_to :trip
end
