class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :user_name, :null => false
      t.string :location
      t.date   :dob
      t.string :description
      t.string :interests
      t.integer :auth_page_layout, :null => false, :default => 0


      t.string :profile_pic_file_name
      t.string :profile_pic_content_type
      t.integer :profile_pic_file_size
      t.datetime :profile_pic_updated_at

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
