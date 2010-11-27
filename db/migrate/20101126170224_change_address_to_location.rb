class ChangeAddressToLocation < ActiveRecord::Migration
  def self.up
    rename_column :locations, :address, :location
  end

  def self.down
    rename_column :locations, :location, :address
  end
end
