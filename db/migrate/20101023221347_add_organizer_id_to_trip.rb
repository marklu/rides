class AddOrganizerIdToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :organizer_id, :integer
  end

  def self.down
    remove_column :trips, :organizer_id
  end
end
