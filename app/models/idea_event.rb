class IdeaEvent < ActiveRecord::Base
  belongs_to :idea
  belongs_to :event
  
  attr_accessible :progress
end
