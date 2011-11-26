class UserIdeasController < ApplicationController
  # GET /user_ideas
  # GET /user_ideas.json
  def index
    @user_ideas = UserIdea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_ideas }
    end
  end

  # GET /user_ideas/1
  # GET /user_ideas/1.json
  def show
    @user_idea = UserIdea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_idea }
    end
  end

  # GET /user_ideas/new
  # GET /user_ideas/new.json
  def new
    @user_idea = UserIdea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_idea }
    end
  end

  # GET /user_ideas/1/edit
  def edit
    @user_idea = UserIdea.find(params[:id])
  end

  # Modified function to only render simple HTML confirm message to AJAX call
  #   should ONLY be used for AJAX calls
  # POST /user_ideas
  # POST /user_ideas.json
  def create
    @user_idea = UserIdea.new
    @user_idea.user_id = params[:user_id]
    @user_idea.idea_id = params[:idea_id]
    @user_idea.time_goal = IDEA_TIMEGOAL_ANYTIME
    @user_idea.status = USER_IDEA_STATUS_SHARING
    @user_idea.want_it_count = 0;
    @user_idea.prod_count = 0;

    respond_to do |format|
      if @user_idea.save!
        format.html { render :partial => 'user_ideas/create_ajax_confirm' }
        
        #format.json { render json: @user_idea, status: :created, location: @user_idea }
      else
        format.html { render action: "new" }
        format.json { render json: @user_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # Couple different areas of the site call this function including: idea-preview from home-auth-page
  #   and kick-em from idea-view-page so params[:source] identifies calling page and js script 
  #   accordingly
  # PUT /user_ideas/1
  # PUT /user_ideas/1.json
  def update
    @user_idea = UserIdea.find(params[:id])
    @source = params[:source]
    updated_user = User.find(@user_idea.user_id)
    @user_name = updated_user.first_name
    
    respond_to do |format|
      if @user_idea.update_attributes(params[:user_idea])
        format.html { render :partial => 'user_ideas/update_response' }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @user_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_ideas/1
  # DELETE /user_ideas/1.json
  def destroy
    @user_idea = UserIdea.find(params[:id])

    # Decrement user_sharing count for main idea object
    @idea = @user_idea.idea
    @idea.num_users_joined = @idea.num_users_joined - 1
    unless @idea.save!
      # TODO: catch save error
      puts " TRACE: UserIdeasController:Destroy - @idea save unsuccessful"
    end
    
    @user_idea.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
end
