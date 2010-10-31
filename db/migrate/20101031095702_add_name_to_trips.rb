class AddNameToTrips < ActiveRecord::Migration
  def self.up
    add_column :trips, :name, :string
  end

  def self.down
    remove_column :trips, :name
  end
end
