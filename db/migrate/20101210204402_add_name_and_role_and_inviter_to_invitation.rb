class AddNameAndRoleAndInviterToInvitation < ActiveRecord::Migration
  def self.up
    add_column :invitations, :name, :string
    add_column :invitations, :role, :string
    add_column :invitations, :inviter, :string
  end

  def self.down
    remove_column :invitations, :name
    remove_column :invitations, :role
    remove_column :invitations, :inviter
  end
end
