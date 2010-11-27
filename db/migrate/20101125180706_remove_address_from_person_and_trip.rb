class RemoveAddressFromPersonAndTrip < ActiveRecord::Migration
  def self.up
    remove_column :people, :address
    remove_column :trips, :address
  end

  def self.down
    add_column :people, :address, :string
    add_column :trips, :address, :string
  end
end
