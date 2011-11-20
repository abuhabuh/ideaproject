class CreateEventPictures < ActiveRecord::Migration
  def change
    create_table :event_pictures do |t|
      t.references :picture
      t.references :event

      t.timestamps
    end
    add_index :event_pictures, :picture_id
    add_index :event_pictures, :event_id
  end
end
