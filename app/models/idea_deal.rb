class IdeaDeal < ActiveRecord::Base
  belongs_to :idea
  belongs_to :deal
  
  attr_accessible :idea_id, :deal_id
end
