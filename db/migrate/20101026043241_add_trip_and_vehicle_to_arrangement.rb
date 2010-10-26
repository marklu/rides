class AddTripAndVehicleToArrangement < ActiveRecord::Migration
  def self.up
    add_column :arrangements, :trip_id, :integer
    add_column :arrangements, :vehicle_id, :integer
    add_index :arrangements, :trip_id
    add_index :arrangements, :vehicle_id
  end

  def self.down
    remove_index :arrangements, :trip_id
    remove_index :arrangements, :vehicle_id
    remove_column :arrangements, :trip_id
    remove_column :arrangements, :vehicle_id
  end
end
