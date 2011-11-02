class Event < ActiveRecord::Base

  has_many :user_events
  has_many :users, :through => :user_events
  
  has_many :idea_events
  has_one :idea, :through => :idea_events
  
  has_attached_file :photo,
    :styles => {
      :medium => "300x300#",
      :thumb => "100x100#",
      :stream => "50x50#"},
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "/:style/:id/:filename"


  attr_accessible :name, :description, :date, :location, :creator, :photo
  
end