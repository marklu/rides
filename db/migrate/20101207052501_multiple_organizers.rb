class MultipleOrganizers < ActiveRecord::Migration
  def self.up
    remove_column :trips, :organizer_id
    create_table :organizers_trips, :id => false do |t|
      t.integer :organizer_id, :null => false
      t.integer :trip_id, :null => false
    end
    add_index :organizers_trips, [:organizer_id, :trip_id], :unique => true
  end

  def self.down
    add_column :trips, :organizer_id, :integer
    remove_index :organizers_trips, :column => [:organizer_id, :trip_id]
    drop_table :organizers_trips
  end
end
