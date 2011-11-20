class UsersController < ApplicationController
  
  # GET /users
  def index
    @users = User.where("id != ?", current_user.id)
  end
  
  # GET /users/1
  def show
    if current_user.id == params[:id].to_i
      redirect_to users_profile_path
    end

    @user = User.find(params[:id])
    @friendship = current_user.friendships.where("friend_id = ?", @user.id).first
    @stream_ideas = @user.ideas.order("num_users_joined DESC")
    @user_idea_ids = User.get_my_idea_ids(current_user)
  end
  
  # GET /users/profile
  def profile
    
  end

  def facebook_callback
    put "CALLBACK HERE!" #TODO: put is a command?
  end

  def set_view_layout
    current_user.auth_page_layout = params[:layout]
    
    unless current_user.save
      puts " TRACE: UserController:set_view_layout - error saving current_user" #TODO: do real error handling
    end
    
    redirect_to :back
  end

end
