class UserIdea < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  attr_accessible :invited, :user_id, :idea_id
  validates_presence_of :user_id, :idea_id
  validates_inclusion_of :invited, :in => [true, false]
end
