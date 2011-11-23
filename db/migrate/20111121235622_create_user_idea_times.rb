class CreateUserIdeaTimes < ActiveRecord::Migration
  def change
    create_table :user_idea_times do |t|
      t.references :user
      t.references :idea
      t.datetime :time

      t.timestamps
    end
    add_index :user_idea_times, :user_id
    add_index :user_idea_times, :idea_id
  end
end
