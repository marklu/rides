class RemovePreferencesFromPerson < ActiveRecord::Migration
  def self.up
    remove_column :people, :music
    remove_column :people, :smoking
  end

  def self.down
    add_column :people, :music, :string
    add_column :people, :smoking, :string
  end
end
