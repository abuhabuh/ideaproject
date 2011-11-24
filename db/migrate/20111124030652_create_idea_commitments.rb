class CreateIdeaCommitments < ActiveRecord::Migration
  def change
    create_table :idea_commitments do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
    add_index :idea_commitments, :user_id
    add_index :idea_commitments, :idea_id
  end
end
