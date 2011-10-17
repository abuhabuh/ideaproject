class Event < ActiveRecord::Base

  attr_accessible :name, :description, :date, :location
  
  has_many :user_events
  has_many :users, :through => :user_events

end
