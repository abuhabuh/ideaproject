class IdeasController < ApplicationController
  
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    #TODO - nil sanity checks on variables
    @idea = Idea.find(params[:id])
    @curr_user_idea_link = current_user.user_ideas.where("idea_id =?", @idea.id).first
    @idea_chat_msgs = @idea.chat_messages.order("id ASC")
    @has_idea = false;
    if current_user.ideas.exists?(@idea.id)
      @has_idea = true;
    end

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end


  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

    # TODO: test this or get rid of this function's view html.erb. I just put this here, never tested it out.
    unless params[:internet_url_path].empty?
      @idea.set_photo_from_url(params[:internet_url_path])
    end 

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])
    
    unless params[:internet_url_path].empty?
      @idea.set_photo_from_url(params[:internet_url_path])
    end
    @idea.text = params[:idea][:text]

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :ok }
    end
  end
  
  
  # Renders JS return for appending additional user who joined to user chat list in left nav
  #   This only happens when the additional user is viewing the idea but has not joined the 
  #     idea. In this case, we ASSUME ONLINE STATUS IS TRUE, since triggered by channel
  #     event of user joining presence channel
  def idea_chat_user_js
    @user = User.find(params[:user_id])
    @status_string = params[:user_status]
    @is_online = true
  
    respond_to do |format|
      # JS is the only format that this function should be called as
      format.js {
        render "idea_chat_user_js.js.erb" # NOTE: PICTURE VIEW MODE is set to view PIC_VIEW_TYPE_USER in js.erb
      }
    end

  end
  
  
  ########################
  # Temp code to make ideas featured
  ########################
  
  # TODO: KEEP THIS? REFACTOR / MOVE IT?
  # Temporary Featured item maintenance page to list ideas and mark them as featured
  def featured_idea_admin
    # In the controller
    @ideas = Idea.order("featured DESC").paginate(:page => params[:page], :per_page => 10)
  end
  
  # TODO: KEEP THIS? REFACTOR / MOVE IT?
  def feature_idea
    @idea = Idea.find(params[:idea_id])
    @idea.featured = params[:feature_num]
    
    unless @idea.save
      puts " TRACE: IdeasController:feature_idea - idea save error"
    end
  
    redirect_to :back
  end
  
  
end
