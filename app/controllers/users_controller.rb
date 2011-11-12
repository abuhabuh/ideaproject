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
    @search_result_ideas = @user.ideas.order("num_users_joined DESC")
    @user_idea_ids = User.get_my_idea_ids(current_user)
  end
  
  # GET /users/profile
  def profile
    
  end

end
