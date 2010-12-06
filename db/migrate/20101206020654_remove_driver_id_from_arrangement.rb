class RemoveDriverIdFromArrangement < ActiveRecord::Migration
  def self.up
    remove_column :arrangements, :driver_id
  end

  def self.down
    add_column :arrangements, :driver_id, :integer
  end
end
