class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, \
    :user_name, :first_name, :last_name, :location, :dob

  has_many :user_ideas
  has_many :ideas, :through => :user_ideas

  has_many :user_events
  has_many :events, :through => :user_events


  # Create new idea object for user
  def create_idea (idea_string)

    idea = Idea.new(:text => idea_string)

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

end
