class CreateAdminMessages < ActiveRecord::Migration
  def change
    create_table :admin_messages do |t|
      t.string :text
      t.references :user

      t.timestamps
    end
    add_index :admin_messages, :user_id
  end
end
