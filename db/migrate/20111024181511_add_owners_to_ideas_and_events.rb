class AddOwnersToIdeasAndEvents < ActiveRecord::Migration
  def change
    add_column :ideas, :creator, :integer
    add_column :events, :creator, :integer
  end
end
