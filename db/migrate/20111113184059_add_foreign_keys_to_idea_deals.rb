class AddForeignKeysToIdeaDeals < ActiveRecord::Migration
  def up
    change_table :idea_deals do |t|
      t.foreign_key :ideas
      t.foreign_key :deals
    end
  end

  def down
    change_table :idea_deals do |t|
      t.remove_foreign_key :deals
      t.remove_foreign_key :ideas
    end
  end
end
