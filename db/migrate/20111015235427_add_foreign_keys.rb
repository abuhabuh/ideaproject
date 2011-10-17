class AddForeignKeys < ActiveRecord::Migration
  def up

    change_table :user_ideas do |t|
      t.foreign_key :users
      t.foreign_key :ideas
    end

    change_table :user_events do |t|
      t.foreign_key :users
      t.foreign_key :events
    end

  end

  def down

    change_table :user_ideas do |t|
      t.remove_foreign_key :users
      t.remove_foreign_key :ideas
    end

    change_table :user_events do |t|
      t.remove_foreign_key :users
      t.remove_foreign_key :events
    end

  end
end
