class AddTimeGoalToUserIdea < ActiveRecord::Migration
  def change
    add_column :user_ideas, :time_goal, :integer, :default => 3
  end
end
