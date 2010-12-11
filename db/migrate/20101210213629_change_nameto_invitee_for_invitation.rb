class ChangeNametoInviteeForInvitation < ActiveRecord::Migration
  def self.up
    rename_column :invitations, :name, :invitee
  end

  def self.down
    rename_column :invitations, :invitee, :name
  end
end
