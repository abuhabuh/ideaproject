class AddForeignKeysToIdeaEvents < ActiveRecord::Migration

  def up
    change_table :idea_events do |t|
      t.foreign_key :ideas
      t.foreign_key :events
    end
  end

  def down
    change_table :idea_events do |t|
      t.remove_foreign_key :events
      t.remove_foreign_key :ideas
    end
  end

end
