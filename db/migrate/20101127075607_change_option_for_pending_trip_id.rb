class ChangeOptionForPendingTripId < ActiveRecord::Migration
  def self.up
    remove_column(:invitations, :pending_trip_id)
    add_column(:invitations, :pending_trip_id, :integer)
  end

  def self.down

  end
end
