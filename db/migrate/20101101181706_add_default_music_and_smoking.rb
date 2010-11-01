class AddDefaultMusicAndSmoking < ActiveRecord::Migration
  def self.up
    change_column_default :people, :music, 'no_preference'
    change_column_default :people, :smoking, 'no_preference'
  end

  def self.down
    change_column :people, :music, :string, :default => nil
    change_column :people, :smoking, :string, :default => nil
  end
end
