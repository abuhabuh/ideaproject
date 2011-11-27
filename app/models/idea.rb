require 'open-uri'


class Idea < ActiveRecord::Base
  has_many :user_ideas
  has_many :users, :through => :user_ideas

  has_many :idea_events
  has_many :events, :through => :idea_events

  has_many :chat_messages
  # TODO: should add has_many :users, :through => :chat_messages ????

  has_many :idea_deals
  has_many :deals, :through => :idea_deals

  has_many :posts
  has_many :idea_commitments;

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
  validates_presence_of :text, :creator, :num_users_joined, :featured


  def set_photo_from_url(url)
    self.photo = open(url)
  end



  ###### CLASS FUNCTIONS ############


  ################# UTILITY FUNCTIONS ######################

  def self.join_idea(user_id, idea_id)
    Idea.add_user_joined(idea_id)
    user_idea = UserIdea.where(:user_id => user_id, :idea_id => idea_id).first
    if user_idea.nil?
      UserIdea.create!(:user_id => user_id,
                       :idea_id => idea_id,
                       :time_goal => IDEA_TIMEGOAL_ANYTIME,
                       :status => USER_IDEA_STATUS_SHARING,
                       :want_it_count => 0,
                       :prod_count => 0,
                       :done_it => false)
    else
      user_idea.update_attributes!(:status => USER_IDEA_STATUS_SHARING)
    end
  end

  def self.has_done_idea(user_id, idea_id)
    user_idea = UserIdea.where(:user_id => user_id, :idea_id => idea_id).first
    if user_idea.nil?
      UserIdea.create!(:user_id => user_id,
                       :idea_id => idea_id,
                       :time_goal => IDEA_TIMEGOAL_ANYTIME,
                       :status => USER_IDEA_STATUS_DONE_IDEA,
                       :want_it_count => 0,
                       :prod_count => 0,
                       :done_it => true)
    else
      user_idea.update_attributes!(:done_it => true)
    end
  end

  def self.add_user_joined(idea_id)
    target_idea = Idea.find(idea_id);

    target_idea.update_attributes!(:num_users_joined => (target_idea.num_users_joined + 1) ) 
  end

end
