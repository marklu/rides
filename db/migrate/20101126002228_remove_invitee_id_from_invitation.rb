class RemoveInviteeIdFromInvitation < ActiveRecord::Migration
  def self.up
    remove_column :invitations, :invitee_id
  end

  def self.down
    add_column :invitations, :invitee_id, :integer
  end
end
