class CreateArrangementsPassengers < ActiveRecord::Migration
  def self.up
    create_table :arrangements_passengers, :id => false do |t|
      t.integer :arrangement_id, :null => false
      t.integer :passenger_id, :null => false
    end
    add_index :arrangements_passengers, [:arrangement_id, :passenger_id], :unique => true
  end

  def self.down
    remove_index :arrangements_passengers, :column => [:arrangement_id, :passenger_id]
    drop_table :arrangements_passengers
  end
end
