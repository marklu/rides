class AddProfileAndPreferencesToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :city, :string
    add_column :people, :state, :string
    add_column :people, :music, :integer
    add_column :people, :smoking, :integer
  end

  def self.down
    remove_column :people, :city
    remove_column :people, :state
    remove_column :people, :music
    remove_column :people, :smoking
  end
end
