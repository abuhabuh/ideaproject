class ChatMessage < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
  
  attr_accessible :text, :idea_id, :user_id
end
