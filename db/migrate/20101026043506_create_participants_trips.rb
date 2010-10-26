class CreateParticipantsTrips < ActiveRecord::Migration
  def self.up
    create_table :participants_trips, :id => false do |t|
      t.integer :participant_id, :null => false
      t.integer :trip_id, :null => false
    end
    add_index :participants_trips, [:participant_id, :trip_id], :unique => true
  end

  def self.down
    remove_index :participants_trips, :column => [:participant_id, :trip_id]
    drop_table :participants_trips
  end
end
