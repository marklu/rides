class AddPersonIdToPrefernces < ActiveRecord::Migration
  def self.up
    add_column :preferences, :person_id, :integer
  end

  def self.down
    remove_column :preferences, :person_id
  end
end
