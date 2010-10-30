class RemoveLocationFromTrips < ActiveRecord::Migration
  def self.up
    remove_column :trips, :location
  end

  def self.down
    add_column :trips, :location, :string
  end
end
