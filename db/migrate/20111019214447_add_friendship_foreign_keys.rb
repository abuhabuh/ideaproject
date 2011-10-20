class AddFriendshipForeignKeys < ActiveRecord::Migration
  def up
    
    change_table :friendships do |t|
      t.foreign_key :users
      t.foreign_key :users, :column => 'friend_id'
    end
    
  end

  def down

    change_table :friendships do |t|
      t.remove_foreign_key :friends
      t.remove_foreign_key :users
    end

  end
end
