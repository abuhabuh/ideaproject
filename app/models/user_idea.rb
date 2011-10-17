class UserIdea < ActiveRecord::Base

  attr_accessible :text, :user_id, :idea_id

  belongs_to :user
  belongs_to :idea


end
