class AdminMessage < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :text, :user_id
  validates_presence_of :text, :user_id
end
