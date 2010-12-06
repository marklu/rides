class InvertLocationAssociations < ActiveRecord::Migration
  def self.up
    remove_column :locations, :locatable_id
    remove_column :locations, :locatable_type

    add_column :arrangements, :origin_id, :integer
    add_column :arrangements, :destination_id, :integer
    add_column :people, :location_id, :integer
    add_column :trips, :location_id, :integer
  end

  def self.down
    add_column :locations, :locatable_id, :integer
    add_column :locations, :locatable_type, :string

    remove_column :arrangements, :origin_id
    remove_column :arrangements, :destination_id
    remove_column :people, :location_id
    remove_column :trips, :location_id
  end
end
