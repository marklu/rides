class AddMakeAndModelToVehicle < ActiveRecord::Migration
  def self.up
    add_column :vehicles, :make, :string
    add_column :vehicles, :model, :string
  end

  def self.down
    remove_column :vehicles, :make
    remove_column :vehicles, :model
  end
end
