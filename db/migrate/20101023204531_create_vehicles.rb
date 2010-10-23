class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.integer :capacity

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
