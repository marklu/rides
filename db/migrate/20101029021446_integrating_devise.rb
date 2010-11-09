class IntegratingDevise < ActiveRecord::Migration
  def self.up
    remove_column :people, :email
    change_table(:people) do |t|
      t.database_authenticatable :null => false
      end
    add_index :people, :email, :unique => true
  end

  def self.down
    change_table(:people) do |t|
      t.remove :database_authenticatable
      t.remove_index :email
    end
    add_column :people, :email
  end
end
