class AddForeignKeysToAdminMessages < ActiveRecord::Migration
  def up
    change_table :admin_messages do |t|
      t.foreign_key :users
    end
  end

  def down
    change_table :admin_messages do |t|
      t.remove_foreign_key :users
    end
  end
end
