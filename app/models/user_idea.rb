class UserIdea < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  attr_accessible :status, :user_id, :idea_id, :time_goal, :want_it_count, :prod_count
  validates_presence_of :user_id, :idea_id, :status
  validates_inclusion_of :status, :in => [USER_IDEA_STATUS_SHARING, 
                                          USER_IDEA_STATUS_INVITED,
                                          USER_IDEA_STATUS_LIKE]
  
  
  def self.time_goal_string(time_goal)
  
    case time_goal
    when IDEA_TIMEGOAL_THIS_WEEK
      return IDEA_TIMEGOAL_THIS_WEEK_STR
    when IDEA_TIMEGOAL_THIS_MONTH
      return IDEA_TIMEGOAL_THIS_MONTH_STR
    when IDEA_TIMEGOAL_THIS_YEAR
      return IDEA_TIMEGOAL_THIS_YEAR_STR
    when IDEA_TIMEGOAL_ANYTIME
      return IDEA_TIMEGOAL_ANYTIME_STR
    end
  
  end
end
