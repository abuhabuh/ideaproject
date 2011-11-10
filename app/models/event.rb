class Event < ActiveRecord::Base

  has_many :user_events
  has_many :users, :through => :user_events
  
  has_many :idea_events
  has_one :idea, :through => :idea_events
    
  # TODO: CRITICAL - CHANGE PHOTO VARIABLE TO ANOTHER VARIABLE NAME TO NOT CONFLICT WITH 
  #       IDEAS MODEL PHOTO STORE LOCATION
  has_attached_file :photo, {
    :styles => {
      :medium => "300x300#",
      :thumb => "100x100#",
      :stream => "50x50#"}
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  attr_accessible :name, :description, :date, :location, :creator, :photo
  
end
