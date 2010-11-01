class RemoveTimeFromTrips < ActiveRecord::Migration
  def self.up
    remove_column :trips, :time
  end

  def self.down
    add_column :trips, :time, :time
  end
end
