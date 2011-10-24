class UsersController < ApplicationController
  
  # GET /users
  def index
    @users = User.where("id != ?", current_user.id)
    
    @friends_ids = Array.new
    @friendships_ids = Array.new
    current_user.friendships.each do |friendship|
      @friends_ids << friendship.friend.id
      @friendships_ids << friendship.id
    end
  end

  # GET /users/profile
  def profile
     
  end

end
