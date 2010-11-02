class AddTimeToTrips < ActiveRecord::Migration
  def self.up
    add_column :trips, :time, :datetime
  end

  def self.down
    remove_column :trips, :time
  end
end
