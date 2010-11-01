class ChangeMusicAndSmokingToString < ActiveRecord::Migration
  def self.up
    change_column :people, :music, :string
    change_column :people, :smoking, :string
  end

  def self.down
    change_column :people, :music, :integer
    change_column :people, :smoking, :integer
  end
end
