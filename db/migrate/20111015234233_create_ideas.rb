class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :text, :null => false
      t.integer :num_users_joined, :null => false, :default => 0
      t.integer :featured, :null => false, :default => 0
      t.integer :creator, :null => false
      
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
