class CreateUserAuths < ActiveRecord::Migration
  def change
    create_table :user_auths do |t|
      t.string :token
      t.string :provider_id
      t.string :provider
      t.integer :user_id      

      t.timestamps
    end

    change_table :user_auths do |t|
      t.foreign_key :users
    end
  end
end
