class IntegratingDevise < ActiveRecord::Migration
  def self.up

    # Need to remove the email column created by the create_people migration
    remove_column :people, :email
    change_table(:people) do |t|
      t.database_authenticatable :null => false
      # t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      # we already have timestamp in the create_people migration
      #t.timestamps

    end
    
    add_index :people, :email,                :unique => true
    # add_index :people, :confirmation_token,   :unique => true
    add_index :people, :reset_password_token, :unique => true
    # add_index :people, :unlock_token,         :unique => true



  end

  def self.down
    change_table(:people) do |t|
      t.remove :database_authenticatable
      # t.remove :confirmable
      t.remove :recoverable
      t.remove :rememberable
      t.remove :trackable
      # t.remove :lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.remove_index :email
      t.remove_index :reset_password_token
    end

    add_column :people, :email


  end
end
