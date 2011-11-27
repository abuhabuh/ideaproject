class CreateIdeaEvents < ActiveRecord::Migration
  def self.up
    create_table :idea_events do |t|
      t.references :idea
      t.references :event

      t.timestamps
    end
    add_index :idea_events, :idea_id
    add_index :idea_events, :event_id

    change_table :idea_events do |t|
      t.foreign_key :ideas
      t.foreign_key :events
    end
  end


  def self.down
    change_table :idea_events do |t|
      t.remove_foreign_key :events
      t.remove_foreign_key :ideas
    end

    drop_table :idea_events
  end
end
