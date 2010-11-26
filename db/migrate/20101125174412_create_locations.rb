class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :locatable_id
      t.string :locatable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
