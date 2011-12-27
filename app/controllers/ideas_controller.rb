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
    @read_only = current_user.nil?
      
    @idea = Idea.find(params[:id])
    @idea_chat_msgs = @idea.chat_messages.order("id ASC")
    @idea_deals = @idea.deals
    @forum_posts = Post.where(:idea_id => @idea.id, :post_id => nil);

    @idea_events = @idea.events
    @idea_users = @idea.users.order("want_it_count DESC, first_name ASC, last_name ASC");
    
    @curr_user_idea_link = @read_only? nil : current_user.user_ideas.where("idea_id =?", @idea.id).first

    @has_idea = false;
    if !@read_only && current_user.ideas.exists?(@idea.id)
      @has_idea = true;
    end

    # Get array of event ids for user's events
    @user_event_ids = Array.new
    unless @read_only
      current_user.events.each do |event|
        @user_event_ids << event.id
      end
    end

    # Get array of user's friends' ids
    friend_ids = Array.new

    unless @read_only
      current_user.friends.each do |friend|
        friend_ids << friend.id
      end
    end
    @friend_ids_str = friend_ids.join(',')

    # Get data to render kick em functionality
    @num_total_pages = @idea_users.size / IDEA_KICK_USERS_NUM_PER_PAGE
    if @idea_users.size % IDEA_KICK_USERS_NUM_PER_PAGE > 0
      @num_total_pages += 1
    end
    if @num_total_pages > 1
      @kickem_users_list = @idea_users[0...IDEA_KICK_USERS_NUM_PER_PAGE]
    else
      @kickem_users_list = @idea_users
    end

    # Get user commitment status
    @is_committed = @read_only? nil : current_user.idea_commitments.exists?(:idea_id => @idea.id)
    @num_commits_outstanding = @read_only? 0 : IdeaCommitment.get_num_commits_outstanding(current_user.id)
    @can_commit = @num_commits_outstanding < NUM_COMMITS_PER_MONTH

    @idea_friends = User.find_friends_in_idea(current_user, @idea.id)

    puts "TESTING FRIEND LIST:::::::::::::: "+@idea_friends.to_yaml

    respond_to do |format|
      format.html { render 'show2' }
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
      if @idea.save!
      
        UserIdea.create(:user_id => current_user.id, :idea_id => @idea.id, :status => USER_IDEA_STATUS_SHARING) # TODO: catch database write error
      
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
    else
      @idea.photo = params[:idea][:photo]
    end
    @idea.text = params[:idea][:text]

    respond_to do |format|
      if @idea.save!
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
  
  
  # Returns HTML partial for appending additional user who joined to user chat list in left nav
  #   This only happens when the additional user is viewing the idea but has not joined the 
  #     idea. In this case, we ASSUME ONLINE STATUS IS TRUE, since triggered by channel
  #     event of user joining presence channel
  def idea_chat_user
    @user = User.find(params[:user_id])
    @status_string = params[:user_status]
    @is_online = true
  
    respond_to do |format|
      format.html {
        render :partial => "idea_chat_user", :locals => {:idea_id => params[:idea_id]}
      }
    end
  end
  
  
  # Returns HTML render of chat_user_list_left_nav.html.erb to be inserted into idea show page
  #   Take argument specifying whether or not to display friends only
  def idea_chat_user_list
  
    idea = Idea.find(params[:idea_id])
    friends_only = params[:friends_only] == 'true'
    friend_ids_str = params[:friend_ids_str]
    
    respond_to do |format|
      format.html {
        render :partial => 'shared_modules/chat_user_list_left_nav', 
               :locals => {:container_id_tag => ID_TAG_IDEA_CHAT_USER_LIST, 
                           :users => idea.users, 
                           :chat_type => CHAT_TYPE_IDEA,
                           :topic_id => idea.id,
                           :friends_only => friends_only,
                           :friend_ids => friend_ids_str}
      }
    end
    
  end
  
  
  # Renders JS for list of users that belong to this idea for displaying in 'kick user' 
  #   facebox window
  # AJAX call only
  # idea_kick_user_list_path
  def idea_kick_user_list
    idea = Idea.find(params[:idea_id])

    current_page = params[:current_page].to_i
    idea_users = idea.users.order("want_it_count DESC, first_name ASC, last_name ASC");
    
    num_total_pages = idea_users.size / IDEA_KICK_USERS_NUM_PER_PAGE
    if idea_users.size % IDEA_KICK_USERS_NUM_PER_PAGE > 0
      num_total_pages += 1
    end

    if current_page > num_total_pages # incase users dropped between client call and server execution
      current_page = num_total_pages
    end
    
    start_index = (current_page-1) * IDEA_KICK_USERS_NUM_PER_PAGE
    if num_total_pages > 1
      @kickem_users_list = idea_users[start_index...(start_index + IDEA_KICK_USERS_NUM_PER_PAGE)] # don't pass copy of this heavy object
    else
      @kickem_users_list = idea_users
    end
    
    respond_to do |format|
      format.js{
        render :partial => 'shared_modules/user_picture_list.js.erb',
               :locals => {:current_page => current_page,
                           :num_total_pages => num_total_pages,
                           :idea_id => params[:idea_id] }
      }
    end
  end
  
  
  # Renders HTML PARTIAL for idea preview AJAX call
  # - used in auth home to load preview content for idea
  def idea_preview
    @idea = Idea.find(params[:idea_id])
    @idea_chat_msgs = @idea.chat_messages.order("id DESC").limit(IDEA_LAYOUT_PREVIEW_NUM_CHATS).reverse

    @curr_user_idea_link = current_user.user_ideas.where("idea_id =?", @idea.id).first

    @has_idea = false;
    if current_user.ideas.exists?(@idea.id)
      @has_idea = true;
    end

    respond_to do |format|
      format.html {
        render :partial => "idea_preview"
      }
    end
  
  end
  
  # Joins user to existing idea object and reloads source page
  # - called from idea view page
  def join_idea_from_idea_view
    if params[:idea_id] && !params[:idea_id].blank?
      @idea = Idea.find(params[:idea_id])
      @idea_assc_type = params[:idea_assc_type]
      current_user.associate_idea(@idea.id, params[:idea_assc_type])
    else
      # Handle unexpected nil error
      puts " TRACE HomeController:join_idea_from_idea_view - no param for idea"
    end
    
    respond_to do |format|
      format.html {
        redirect_to :back
      }
    end
  end

  ###### Controller functions that handle ajax requests from 'join idea' button
  # Joins user to existing idea, Doesn't create new idea object 

  def button_associate_idea_block
    idea_id = params[:idea_id].to_i
    idea_assc_type = params[:idea_assc_type].to_i
  
    current_user.associate_idea(idea_id, idea_assc_type)
  
    respond_to do |format|
      format.js {
        render :partial => '/ideas/button_associate_idea_block', 
               :locals => {:idea_id => idea_id,
                           :idea_assc_type => idea_assc_type}
      }
    end
  end

  def button_associate_idea_stream
    idea_id = params[:idea_id].to_i
    idea_assc_type = params[:idea_assc_type].to_i
  
    current_user.associate_idea(idea_id, idea_assc_type)

    unless params[:view_type].to_i == IDEA_STREAM_NO_PREVIEW
      # BEGIN variable declarations for idea preview rendering for js response construction
      @idea = Idea.find(params[:idea_id])
      @idea_chat_msgs = @idea.chat_messages.order("id DESC").limit(IDEA_LAYOUT_PREVIEW_NUM_CHATS).reverse

      @curr_user_idea_link = current_user.user_ideas.where("idea_id =?", @idea.id).first

      @has_idea = false;
      if current_user.ideas.exists?(@idea.id)
        @has_idea = true;
      end
      # END variable declarations for idea preview rendering
    end

    respond_to do |format|
      format.js {
        render :partial => '/ideas/button_associate_idea_stream', 
               :locals => {:idea_id => idea_id,
                           :idea_assc_type => idea_assc_type,
                           :view_type => params[:view_type]}
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
    
    unless @idea.save!
      puts " TRACE: IdeasController:feature_idea - idea save error"
    end
  
    redirect_to :back
  end
  
  def new_forum_topic
    puts "Made it here!!!!!!!!!!"
    @post = Post.new(params[:post])

    @post.user_id = current_user.id
    
    @post.save
   
    respond_to do |format|
      format.html {render :partial => 'forum/forum_display', :locals => {:posts => [@post], :level => 2, :postCount => 2} }   #{ redirect_to Idea.find_by_id(@post.idea_id) }
      format.json 
    end
 
  end
   
end
