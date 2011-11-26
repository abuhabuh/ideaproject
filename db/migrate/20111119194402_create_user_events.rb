class CreateUserEvents < ActiveRecord::Migration
  def self.up
    create_table :user_events do |t|
      t.references :user
      t.references :event
      t.integer :status, :null => false

      t.timestamps
    end
    add_index :user_events, :user_id
    add_index :user_events, :event_id

    change_table :user_events do |t|
      t.foreign_key :users
      t.foreign_key :events
    end
  end


  def self.down
    change_table :user_events do |t|
      t.remove_foreign_key :events
      t.remove_foreign_key :users
    end

    drop_table :user_events
  end
end
