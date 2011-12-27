require 'open-uri'


class Idea < ActiveRecord::Base
  acts_as_taggable

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

  def self.search_ideas(search_string, ideas_per_page, current_page)
    if search_string == INPUT_BOX_SEARCH_IDEAS
      search_string = ""
    end

    page_number = 1    
    unless current_page.nil? || current_page.blank?
      page_number = current_page.to_i
    end
 
    if search_string.nil? || search_string.empty?
      return Idea.limit(ideas_per_page).offset((page_number-1)*ideas_per_page).order("num_users_joined DESC, text ASC")
    else
    
      @search = Idea.search do
        fulltext search_string.to_s, :minimum_match => 1
        order_by :num_users_joined, :desc
        paginate :page => page_number, :per_page => ideas_per_page
      end
      
      @search.results
    end

  end


  def self.search_ideas_tags(tag_str_arr, ideas_per_page, current_page)

    puts " ************* SEARCH_IDEAS_TAGS ****************"
    puts " ************* SEARCH_IDEAS_TAGS ****************"
    puts " ************* SEARCH_IDEAS_TAGS ****************"

    page_number = 1    
    unless current_page.nil? || current_page.blank?
      page_number = current_page.to_i
    end

    ideas = Idea.tagged_with(tag_str_arr, :any => true).limit(ideas_per_page).offset((page_number-1)*ideas_per_page)

    ideas.each do |idea_item|
      puts "idea text: " + idea_item.text + " id: " + idea_item.id.to_s
      puts "  tag matches: " + idea_item.tag_counts.where(:name => tag_str_arr).count.to_s
    end

    ideas.sort_by! {|idea_item| -(idea_item.tag_counts.where(:name => tag_str_arr).count)}

    puts "sorted"
    ideas.each do |idea_item|
      puts "idea text: " + idea_item.text
    end

    return ideas

  end


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
