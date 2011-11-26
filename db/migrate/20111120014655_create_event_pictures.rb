class CreateEventPictures < ActiveRecord::Migration
  def self.up
    create_table :event_pictures do |t|
      t.references :picture
      t.references :event

      t.timestamps
    end
    add_index :event_pictures, :picture_id
    add_index :event_pictures, :event_id

    change_table :event_pictures do |t|
      t.foreign_key :pictures
      t.foreign_key :events
    end
  end


  def self.down
    change_table :event_pictures do |t|
      t.remove_foreign_key :pictures
      t.remove_foreign_key :events
    end
  	
  	drop_table :event_pictures
  end
end
