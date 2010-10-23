class CreateArrangements < ActiveRecord::Migration
  def self.up
    create_table :arrangements do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :arrangements
  end
end
