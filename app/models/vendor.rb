class Vendor < ActiveRecord::Base

  has_many :deals

  attr_accessible :name, :location
  
end
