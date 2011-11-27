class AddDoneItColumnToUserIdeas < ActiveRecord::Migration
  def change
  	add_column :user_ideas, :done_it, :boolean, :null => false, :default => false
  end
end
