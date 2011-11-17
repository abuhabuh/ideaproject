require 'open-uri'

class Deal < ActiveRecord::Base
  has_many :idea_deals
  has_many :ideas, :through => :idea_deals

  has_one :vendor

  has_attached_file :deal_photo, {:default_url => '/images/deals/:style/deal_default.jpg', 
                             :styles => {
                               :medium => "450x300#",
                               :thumb => "150x100#",
                               :featured => "105x70#",
                               :stream => "50x50#"}
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  # Sunspot search index
  # SUNSPOT WIKI!!!!! https://github.com/sunspot/sunspot/wiki
  searchable do
    text :title, :boost => 2.0
    text :description
    float :price
    time :start_date
    time :end_date
  end

  attr_accessible :title, :description, :vendor_name, :location, :purchase_link, 
                  :price, :original_price, :percent_off, :start_date, :end_date, 
                  :deal_photo, :user_id
  validates_presence_of :title, :description, :vendor_name, :price

  def set_photo_from_url(url)
    self.deal_photo = open(url)
  end

end
