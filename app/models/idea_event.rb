class IdeaEvent < ActiveRecord::Base
  belongs_to :idea
  belongs_to :event
  
  validates_presence_of :idea_id, :event_id
end
