class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :user_ideas
  has_many :ideas, :through => :user_ideas

  has_many :user_events
  has_many :events, :through => :user_events

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :chat_messages
  #TODO: should add has_many :ideas, :through => :chat_messages ????

  # Setup paperclip photo attachment property
  has_attached_file :profile_pic, :styles => { :medium => "300x300#", :thumb => "100x100#", :stream => "50x50#" }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, \
    :user_name, :first_name, :last_name, :location, :dob, :profile_pic, \
    :description, :interests

  # Create new idea object for user
  def create_idea (idea_string)

    idea = Idea.new(:text => idea_string, :creator => self.id)

    # Save both idea object and user / idea pair to DB
    if (idea.save)
      puts " TRACE User:create_idea - saved idea"
      puts " TRACE User:create_idea - " + idea.inspect
      user_idea = UserIdea.new(:user_id => self[:id], :idea_id => idea.id)
      user_idea.save
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
  def join_idea (idea_id)
    # TODO: check input: is number, is not an idea user already has
    
    user_idea = UserIdea.new(:user_id => self[:id], :idea_id => idea_id)
    if (user_idea.save)
      puts " TRACE User:join_idea - user_idea saved successfully"
    else
      puts " TRACE User:join_idea - error saving user_idea"
    end
    
  end




  # Returns user's ideas as relation that can be operated on or queried
  def self.get_my_ideas (current_user)
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
  def self.get_my_friends_ideas (current_user)
    
    current_user.friendships\
                .joins('INNER JOIN user_ideas ON friendships.friend_id = user_ideas.user_id')\
                .joins('INNER JOIN ideas ON user_ideas.idea_id = ideas.id')\
                .group('user_ideas.idea_id')\
                .select('ideas.text as idea_text, ideas.id as idea_id, ideas.creator as idea_creator, count(user_ideas.idea_id) as user_count')
    
  end
  
  # Returns all public ideas grouped by idea id with count of all users who
  #   subscribe to the idea
  #   Return parameters have to be same as get_my_friends_ideas

  #   TODO: param that specifies how many rows to get at a time
  def self.get_public_ideas

    UserIdea.joins(:idea)\
            .joins(:user)\
            .group('ideas.id')\
            .select('ideas.text as idea_text, ideas.id as idea_id, ideas.creator as idea_creator, count(ideas.id) as user_count')
            
  end

end
