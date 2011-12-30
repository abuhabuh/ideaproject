class UsersController < ApplicationController
  
  # GET /users
  def index

    users_per_page = 10
    params[:page_number] ||= 1
    params[:user_name] ||= ''
    @page_number = params[:page_number].to_i
    @user_name = params[:user_name]
    total_other_users = User.count - 1

    if @user_name == ''
      puts "user name = empty so getting all"
      @users = User.where("id != ?", current_user.id).order("first_name ASC, last_name ASC")
                   .limit(users_per_page)
                   .offset((@page_number-1)*users_per_page)
    else
      # DOESN'T WORK RIGHT NOW, SEARCH IS NOT INDEXED RIGHT OR SOMETHING ELSE IS WRONG....DUNNO
      puts "doing full text search - username: " + @user_name

      @search_results = User.search do
        fulltext @user_name.to_s, :minimum_match => 1
      end
      @users = @search_results.results
    end 

    @num_total_pages = 1 # init variable to default    
    if total_other_users % users_per_page > 0
      @num_total_pages = total_other_users/users_per_page + 1
    else
      @num_total_pages = total_other_users/users_per_page
    end

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
  end

  def change_user_password
    render 'devise/registrations/change_password'
  end

  def set_view_layout
    current_user.auth_page_layout = params[:layout]
    
    unless current_user.save
      puts " TRACE: UserController:set_view_layout - error saving current_user" #TODO: do real error handling
    end
    
    redirect_to root_url
  end

end
