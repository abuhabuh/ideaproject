class CreateChatMessages < ActiveRecord::Migration
  def self.up
    create_table :chat_messages do |t|
      t.references :idea
      t.references :user
      t.string :text, :null => false

      t.timestamps
    end

    add_index :chat_messages, :idea_id
    add_index :chat_messages, :user_id

    change_table :chat_messages do |t|
      t.foreign_key :ideas
      t.foreign_key :users
    end

  end

  def self.down
    change_table :chat_messages do |t|
      t.remove_foreign_key :users
      t.remove_foreign_key :ideas      
    end

    drop_table :chat_messages
  end
end
