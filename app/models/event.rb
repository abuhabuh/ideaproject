#name:string 
#description:string 
#location:string 
#start_date:date 
#end_date:date 

#visibility:integer - enumerable in constants.rb
#status:integer - enumerable in constants.rb

#num_users_joined:integer

class Event < ActiveRecord::Base

  has_one :idea_event
  has_one :idea, :through => :idea_event
  
  has_many :user_events
  has_many :users, :through => :user_events

  has_many :event_pictures
  has_many :pictures, :through => :event_pictures

  attr_accessible :name, :description, :location, :start_date, :end_date, :visibility, :status, :num_users_joined
  validates_presence_of :name, :visibility, :status
  
  validates_inclusion_of :visibility, :in => [USER_EVENT_VISIBILITY_PUBLIC, 
                                              USER_EVENT_VISIBILITY_FRIENDS, 
                                              USER_EVENT_VISIBILITY_INVITE_ONLY]
  validates_inclusion_of :status, :in => [USER_EVENT_STATUS_ATTENDING,
                                          USER_EVENT_STATUS_MAYBE,
                                          USER_EVENT_STATUS_NOT_ATTENDING,
                                          USER_EVENT_STATUS_LIKE,
                                          USER_EVENT_STATUS_INVITED,
                                          USER_EVENT_STATUS_ADMIN]

end
