class AddForeignKeysToUserEvents < ActiveRecord::Migration

  def up
    change_table :user_events do |t|
      t.foreign_key :users
      t.foreign_key :events
    end
  end

  def down
    change_table :user_events do |t|
      t.remove_foreign_key :events
      t.remove_foreign_key :users
    end
  end

end
