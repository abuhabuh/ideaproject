class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.references :user
      t.references :event
      t.integer :status

      t.timestamps
    end
    add_index :user_events, :user_id
    add_index :user_events, :event_id
  end
end
