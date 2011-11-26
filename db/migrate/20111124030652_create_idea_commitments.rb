class CreateIdeaCommitments < ActiveRecord::Migration
  def self.up
    create_table :idea_commitments do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
    add_index :idea_commitments, :user_id
    add_index :idea_commitments, :idea_id

    change_table :idea_commitments do |t|
      t.foreign_key :users
      t.foreign_key :ideas
    end
  end


  def self.down
    change_table :idea_commitments do |t|
      t.remove_foreign_key :ideas
      t.remove_foreign_key :users
    end

    drop_table :idea_commitments
  end
end
