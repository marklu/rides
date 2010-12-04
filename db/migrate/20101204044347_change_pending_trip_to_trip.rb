class ChangePendingTripToTrip < ActiveRecord::Migration
  def self.up
    rename_column :invitations, :pending_trip_id, :trip_id
  end

  def self.down
    rename_column :invitations, :trip_id, :pending_trip_id
  end
end
