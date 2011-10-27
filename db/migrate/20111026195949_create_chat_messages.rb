class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.references :idea
      t.string :text
      t.references :user

      t.timestamps
    end
    add_index :chat_messages, :idea_id
    add_index :chat_messages, :user_id
  end
end
