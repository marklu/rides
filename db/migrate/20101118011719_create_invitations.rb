class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.timestamp :created_at
      t.integer :invitee_id, :null => false
      t.integer :pending_trip_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
