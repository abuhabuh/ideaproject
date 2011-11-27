class CreateAdminMessages < ActiveRecord::Migration
  def self.up
    create_table :admin_messages do |t|
      t.string :text, :null => false
      t.references :user

      t.timestamps
    end
    add_index :admin_messages, :user_id

    change_table :admin_messages do |t|
      t.foreign_key :users
    end

  end

  def self.down
    change_table :admin_messages do |t|
      t.remove_foreign_key :users
    end

  	drop_table :admin_messages
  end
end
