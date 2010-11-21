class ChangeToSingleFieldAddress < ActiveRecord::Migration
  def self.up
    remove_column :people, :city
    remove_column :people, :state
    remove_column :trips, :city
    remove_column :trips, :state
  end

  def self.down
    add_column :people, :city, :string
    add_column :people, :state, :string
    add_column :trips, :city, :string
    add_column :trips, :state, :string
  end
end
