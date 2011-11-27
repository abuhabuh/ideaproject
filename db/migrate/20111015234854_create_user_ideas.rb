class CreateUserIdeas < ActiveRecord::Migration
  def self.up
    create_table :user_ideas do |t|
      t.integer :status, :null => false, :default => 0
      t.integer :time_goal, :null => false, :default => 3
      t.integer :want_it_count, :null => false, :default => 0
      t.integer :prod_count, :null => false, :default => 0

      t.references :user
      t.references :idea

      t.timestamps
    end

    add_index :user_ideas, :user_id
    add_index :user_ideas, :idea_id

    # add foreign keys
    change_table :user_ideas do |t|
      t.foreign_key :users
      t.foreign_key :ideas
    end

  end


  def self.down
    
    # remove foreign keys
    change_table :user_ideas do |t|
      t.remove_foreign_key :users
      t.remove_foreign_key :ideas
    end

    drop_table :user_ideas
  end
end
