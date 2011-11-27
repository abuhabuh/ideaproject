class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :omniauthable

  # Associations
  has_many :user_ideas
  has_many :ideas, :through => :user_ideas

  has_many :user_events
  has_many :events, :through => :user_events

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :chat_messages

  has_many :user_auths

  has_many :idea_commitments

  # Setup paperclip photo attachment property
  has_attached_file :profile_pic,
                    {:default_url => '/images/users/:style/default.jpg', 
                     :styles => {
                        :medium => "300x300#",
                        :thumb => "100x100#",
                        :stream => "50x50#",
                        :chat => "35x35#"}
                    }.merge(PAPERCLIP_STORAGE_OPTIONS)
                      
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, \
    :user_name, :first_name, :last_name, :location, :dob, :profile_pic, \
    :description, :interests, :profile_pic_file_name, :auth_page_layout
  validates_presence_of :email, :first_name, :last_name, :user_name

  # Create new idea object for user
  def create_idea (idea_string)

    idea = Idea.new(:text => idea_string, :creator => self.id, :num_users_joined => 1)

    # Save both idea object and user / idea pair to DB
    if idea.save!
      puts " TRACE User:create_idea - saved idea"
      puts " TRACE User:create_idea - " + idea.inspect

      user_idea = UserIdea.new(:user_id => self[:id], 
                               :idea_id => idea.id, 
                               :status => USER_IDEA_STATUS_SHARING,
                               :done_it => false)
      user_idea.save!

      puts " TRACE User:create_idea - " + user_idea.inspect
      # TODO: Catch error saving user_idea
    else
      # TODO: Handle error
      puts "DATABASE WRITE ERROR: error saving new idea"
    end

    # TODO: Add idea object to user's array of idea objects
    puts "IDEA added for  user: idea id - #{idea.id} : user id - #{self[:id]}"
  end

  # Join the user to the idea
  # TODO: check input: is number, is not an idea user already has
  def associate_idea (idea_id, idea_assc_type)
    case idea_assc_type.to_i

    when IDEA_ASSC_ADD_IDEA
      Idea.join_idea(self[:id], idea_id)

    when IDEA_ASSC_DONE_IDEA
      Idea.has_done_idea(self[:id], idea_id)

    end
  end

  # Returns user's ideas as relation that can be operated on or queried
  def self.get_my_ideas (current_user)
    puts "user view: #{current_user.to_yaml}"
    current_user.ideas
  end
  
  # Returns user's ideas' ids as array of idea ids
  def self.get_my_idea_ids (current_user)
    query_results = current_user.ideas.select('ideas.id')
    
    idea_ids = Array.new
    query_results.each do |item|
      idea_ids << item.id.to_s
    end
    
    return idea_ids
  end

  # Returns idea of user's friends
  #   Return parameters have to be same as get_public_ideas
  def self.get_my_friends_ideas (current_user, ideas_per_page, current_page)
    
    search_results = current_user.friendships\
                                 .joins('INNER JOIN user_ideas ON friendships.friend_id = user_ideas.user_id')\
                                 .joins('INNER JOIN ideas ON user_ideas.idea_id = ideas.id')\
                                 .group('user_ideas.idea_id, ideas.id')\
                                 .select('ideas.id, count(user_ideas.idea_id) as user_count')\
                                 .order('user_count DESC')\
                                 .offset((current_page.to_i-1) * ideas_per_page.to_i)\
                                 .limit(ideas_per_page.to_i)
 
    ideas = Array.new
    search_results.each do |result|
      ideas << Idea.find(result.id)
    end
    
    return ideas
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil, provider)
    primary_user_data = access_token['info']

    user = User.joins(:user_auths) # TODO: Why is this a User.joins(:user_auths) and not just a UserAuth.where(...)
               .where('user_auths.provider' => provider, 'user_auths.provider_id' => access_token['uid'])
               .readonly(false)
               .first

    if user.nil?
      user = User.create!(:email => primary_user_data["email"], 
                          :first_name => primary_user_data["first_name"], 
                          :last_name => primary_user_data["last_name"],
                          :user_name => primary_user_data["first_name"], 
                          :password => Devise.friendly_token[0,20], 
                          :profile_pic_file_name => primary_user_data['image'].sub('=square', '=normal')
                          ) 
      UserAuth.create(:token => access_token['credentials']['token'], 
                      :provider_id => access_token['uid'], 
                      :provider => provider, 
                      :user_id => user.id
                      )
    end
    return user;
  end

  # overriding Devise password functionality
  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end	


end
