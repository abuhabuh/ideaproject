class CreateUserAuths < ActiveRecord::Migration
  def self.up
    create_table :user_auths do |t|
      t.string :token, :null => false
      t.string :provider_id, :null => false
      t.string :provider, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    change_table :user_auths do |t|
      t.foreign_key :users
    end
  end

  def self.down
    change_table :user_auths do |t|
      t.remove_foreign_key :users
    end

    drop_table :user_auths
  end
end
