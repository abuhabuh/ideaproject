class EventPicture < ActiveRecord::Base
  belongs_to :picture
  belongs_to :event
  
  attr_accessible :picture_id, :event_id
end
