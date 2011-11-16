class AddOwnersToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :creator, :integer
  end
end
