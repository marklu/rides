class CreateInviteesTrips < ActiveRecord::Migration
  def self.up
    create_table :invitees_trips, :id => false do |t|
      t.integer :invitee_id, :null => false
      t.integer :trip_id, :null => false
    end
    add_index :invitees_trips, [:invitee_id, :trip_id], :unique => true
  end

  def self.down
    remove_index :invitees_trips, :column => [:invitee_id, :trip_id]
    drop_table :invitees_trips
  end
end
