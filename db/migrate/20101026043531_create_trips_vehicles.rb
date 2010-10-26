class CreateTripsVehicles < ActiveRecord::Migration
  def self.up
    create_table :trips_vehicles, :id => false do |t|
      t.integer :trip_id, :null => false
      t.integer :vehicle_id, :null => false
    end
    add_index :trips_vehicles, [:trip_id, :vehicle_id], :unique => true
  end

  def self.down
    remove_index :trips_vehicles, :column => [:trip_id, :vehicle_id]
    drop_table :trips_vehicles
  end
end
