class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :idea
      t.references :user
      t.references :post
      t.boolean :delete_flag

      t.timestamps
    end
    add_index :posts, :idea_id
    add_index :posts, :user_id
    add_index :posts, :post_id
  end
end
