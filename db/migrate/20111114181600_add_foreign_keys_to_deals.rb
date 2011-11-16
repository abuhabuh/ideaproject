class AddForeignKeysToDeals < ActiveRecord::Migration
  def up
    
    change_table :deals do |t|
      t.foreign_key :users
    end
    
  end

  def down

    change_table :deals do |t|
      t.remove_foreign_key :users
    end

  end
end
