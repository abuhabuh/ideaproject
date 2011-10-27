class AddForeignKeysToChatMessages < ActiveRecord::Migration
  def up
    change_table :chat_messages do |t|
      t.foreign_key :ideas
      t.foreign_key :users
    end
  end
  
  def down
    change_table :chat_messages do |t|
      t.remove_foreign_key :users
      t.remove_foreign_key :ideas      
    end
  end
end
