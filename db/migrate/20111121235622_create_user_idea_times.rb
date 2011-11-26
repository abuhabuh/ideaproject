class CreateUserIdeaTimes < ActiveRecord::Migration
  def self.up
    create_table :user_idea_times do |t|
      t.references :user
      t.references :idea
      t.datetime :time, :null => false

      t.timestamps
    end
    add_index :user_idea_times, :user_id
    add_index :user_idea_times, :idea_id

    change_table :user_idea_times do |t|
      t.foreign_key :users
      t.foreign_key :ideas
    end
  end


  def self.down
    change_table :user_idea_times do |t|
      t.remove_foreign_key :ideas
      t.remove_foreign_key :users
    end

    drop_table :user_idea_times
  end
end
