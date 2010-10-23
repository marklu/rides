class AddDriverIdToArrangement < ActiveRecord::Migration
  def self.up
    add_column :arrangements, :driver_id, :integer
  end

  def self.down
    remove_column :arrangements, :driver_id
  end
end
