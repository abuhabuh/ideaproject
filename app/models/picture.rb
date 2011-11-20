require 'open-uri'


class Picture < ActiveRecord::Base

  has_many :event_pictures
  has_many :events, :through => :event_pictures

  has_attached_file :picture, {:default_url => '/images/picture/:style/picture_default.jpg', 
                             :styles => {
                               :medium => "450x300#",
                               :thumb => "150x100#",
                               :featured => "105x70#",
                               :stream => "50x50#"}
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  attr_accessible :description
  
  def set_photo_from_url(url)
    self.picture = open(url)
  end

end
