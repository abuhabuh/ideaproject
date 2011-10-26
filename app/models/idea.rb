class Idea < ActiveRecord::Base
  
  has_many :user_ideas
  has_many :users, :through => :user_ideas

  has_many :idea_events
  has_many :events, :through => :idea_events

  has_attached_file :photo, :styles => { :medium => "300x300#", :thumb => "100x100#", :stream => "50x50#" }

  attr_accessible :text, :photo, :creator, :photo

end
