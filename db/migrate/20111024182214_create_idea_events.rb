class CreateIdeaEvents < ActiveRecord::Migration
  def change
    create_table :idea_events do |t|
      t.string :progress
      t.references :idea
      t.references :event

      t.timestamps
    end
    add_index :idea_events, :idea_id
    add_index :idea_events, :event_id
  end
end
