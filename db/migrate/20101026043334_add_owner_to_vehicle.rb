class AddOwnerToVehicle < ActiveRecord::Migration
  def self.up
    add_column :vehicles, :owner_id, :integer
    add_index :vehicles, :owner_id
  end

  def self.down
    remove_index :vehicles, :owner_id
    remove_column :vehicles, :owner_id
  end
end
