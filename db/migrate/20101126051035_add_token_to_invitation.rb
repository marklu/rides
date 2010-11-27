class AddTokenToInvitation < ActiveRecord::Migration
  def self.up
    add_column :invitations, :token, :string
  end

  def self.down
    remove_column :invitations, :token
  end
end
