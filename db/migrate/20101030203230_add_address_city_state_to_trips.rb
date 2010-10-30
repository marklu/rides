class AddAddressCityStateToTrips < ActiveRecord::Migration
  def self.up
    add_column :trips, :address, :string
    add_column :trips, :city, :string
    add_column :trips, :state, :string
  end

  def self.down
    remove_column :trips, :state
    remove_column :trips, :city
    remove_column :trips, :address
  end
end
