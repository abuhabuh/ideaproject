class AddForeignKeysToIdeaCommitment < ActiveRecord::Migration
  def up
    change_table :idea_commitments do |t|
      t.foreign_key :users
      t.foreign_key :ideas
    end
  end

  def down
    change_table :idea_commitments do |t|
      t.remove_foreign_key :ideas
      t.remove_foreign_key :users
    end
  end
end
