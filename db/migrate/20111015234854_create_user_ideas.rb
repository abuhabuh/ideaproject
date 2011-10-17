class CreateUserIdeas < ActiveRecord::Migration
  def change
    create_table :user_ideas do |t|
      t.boolean :invited
      t.references :user
      t.references :idea

      t.timestamps
    end
    add_index :user_ideas, :user_id
    add_index :user_ideas, :idea_id
  end
end
