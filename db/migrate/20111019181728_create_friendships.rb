class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :friendships, [:user_id, :friend_id], :unique => true
    
    change_table :friendships do |t|
      t.foreign_key :users
      t.foreign_key :users, :column => 'friend_id'
    end

  end


  def self.down
    change_table :friendships do |t|
      t.remove_foreign_key :friends
      t.remove_foreign_key :users
    end

    drop_table :friendships
  end
end
