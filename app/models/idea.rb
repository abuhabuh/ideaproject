require 'open-uri'


class Idea < ActiveRecord::Base
  
  has_many :user_ideas
  has_many :users, :through => :user_ideas

  has_many :idea_events
  has_many :events, :through => :idea_events

  has_many :chat_messages
  # TODO: should add has_many :users, :through => :chat_messages ????

  has_attached_file :photo, {:default_url => '/images/ideas/:style/idea_default.jpg', 
                             :styles => {
                               :medium => "450x300#",
                               :thumb => "150x100#",
                               :featured => "105x70#",
                               :stream => "50x50#"}
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)
  
  # Sunspot search index
  # SUNSPOT WIKI!!!!! https://github.com/sunspot/sunspot/wiki
  searchable do
    text :text
    integer :num_users_joined
  end
  
  attr_accessible :text, :photo, :creator, :num_users_joined, :featured


  def set_photo_from_url(url)
    self.photo = open(url)
  end

end
