class AddUsersJoinedColumnToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :num_users_joined, :integer
  end
end
