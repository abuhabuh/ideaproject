class AddUsersJoinedColumnToIdeasAndEvents < ActiveRecord::Migration
  def change
    add_column :ideas, :num_users_joined, :integer
    add_column :events, :num_users_joined, :integer
  end
end
