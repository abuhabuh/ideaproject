class Idea < ActiveRecord::Base

  attr_accessible :text

  has_many :user_ideas
  has_many :users, :through => :user_ideas


end
