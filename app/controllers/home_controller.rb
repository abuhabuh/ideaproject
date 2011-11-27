class HomeController < ApplicationController

  def index
    # User hits index controller as authenticated or as unauthenticated
    #   1. Unauthenticated users taken to index page with idea input
    #   2. Authenticated users taken to main home page
    if user_signed_in?
      redirect_to :action => :authenticated_home # TODO: still requires round trip to browser 
    end
  end

  
  def authenticated_home
    # TODO check all session params in each function in this .rb file
    unless params[:stream_view]
      params[:stream_view] = STREAM_VIEW_PUBLIC # first hitting page - default to public stream view
    end
    # make sure we have stream_view variable in session
    session[:stream_view] = params[:stream_view]
    params[:page] ||= 1
    session[:page] = params[:page] # session[:page] is written to hidden div on html page to support
                                   #   ajax call to render more ideas on stream
    
    # Case1: users have inputed an idea and have just authenticated
    #        or logged in. They should have an idea string in the session
    # Case2: users have not inputed an idea so just render main page
    @initial_idea_string = nil
    if session[:initial_idea_string] && !session[:initial_idea_string].blank?
      # Pass idea to view
      @initial_idea_string = session[:initial_idea_string]
      
      # Delete idea from session
      session.delete(:initial_idea_string)
      if session[:initial_idea_string]
        puts " TRACE HomeController:index - error deleting session param"
      else
        puts " TRACE HomeController:index - deleted session param"
      end

      # TODO: Render more complex idea matching 
      #       There is idea in session.
      #  1. Match idea
      #  2. Show list of matches
      #  3. Show option to add match as idea or add new idea
      #  For now, just add idea as new idea for user
    end
    
    # Determine what we're sorting on
    # TODO: IMPLEMENT THIS
    
    if session[:stream_view] == STREAM_VIEW_FRIENDS    
      # Don't need to get this if we're doing PUBLIC or SEARCH views
      @stream_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
    else
      @stream_ideas = search_ideas(params[:search], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
    end

    # Get featured ideas in order of most featured
    @featured_ideas = Idea.where("featured != ?", NOT_FEATURED).order("featured DESC")

    if current_user.auth_page_layout == PAGE_LAYOUT_AUTH_HOME_STREAM
      # Load first idea variables for default preview display
      @idea = @stream_ideas[0]
      unless @idea.nil?
        @idea_chat_msgs = @idea.chat_messages.order("id DESC").limit(IDEA_LAYOUT_PREVIEW_NUM_CHATS).reverse
        @curr_user_idea_link = current_user.user_ideas.where("idea_id =?", @idea.id).first
        @has_idea = false;
        if current_user.ideas.exists?(@idea.id)
          @has_idea = true;
        end
      end
    end
  end


  # Renders HTML return content for appending additional stream content to auth home stream
  # - works for friends ideas and search ideas
  # - need to have :page parameter is passed in and :stream_view is in session
  def next_ideas_batch_js
    session[:page] = params[:page] # session[:page] written to hidden div to support ajax

    respond_to do |format|
      format.html {
        if session[:stream_view] == STREAM_VIEW_FRIENDS
          @stream_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
        else
          @stream_ideas = search_ideas(params[:idea], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
        end

        render :partial => "next_search_ideas_batch" # NOTE: PICTURE VIEW MODE is set to view PIC_VIEW_TYPE_USER in js.erb
      }
    end

  end



  # Processes initial idea from unauthenticated page
  #   TODO: May need to show ideas that match this one
  # POST /ideas/process_idea
  def process_idea

    # TODO: validate :idea parameter on client side through
    #   form validation
    if params[:idea] && !params[:idea].blank?
      @ideaText = params[:idea]
      
      # Add string to session to save for when user
      #   authenticates
      session[:initial_idea_string] = params[:idea]
      
      @stream_ideas = search_ideas(params[:idea], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
    else
      # Handle unexpected nil error
      puts " TRACE IdeasController:process_idea - no param for idea"
    end
    
  end


  # Adds new idea to user idea object
  # Creates new idea in database
  #   @input: idea needs to be in params
  #   - Don't need to see if new idea matches because this will be handled when
  #     user first views idea detail page (this is for user convenience and to
  #     promote the ease of adding a bunch of ideas quickly)
  # POST /ideas/add_idea
  def add_idea
    if params[:idea] && !params[:idea].blank?
      current_user.create_idea(params[:idea])
    else
      # Handle unexpected nil error
      puts " TRACE HomeController:add_idea - no param for idea"
    end
    
    puts " home_controller: add_idea - idea added"
    
    respond_to do |format|
      format.html {

        unless session[:stream_view] == STREAM_VIEW_FRIENDS
          puts " GETTING SEARCH RESULTS <add_idea> - [" + params[:search].to_s + "]"
          @stream_ideas = search_ideas(params[:search], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
        else
          puts " GETTING FRIENDS RESULTS"
          # Get stream ideas based on what type of stream we're 
          #   rendering: Public, Friends, etc. Default is public view.
          @stream_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          
        end

        flash[:notice] = USER_ACTION_NEW_IDEA_CREATED

        redirect_to authenticated_home_path
      }
      # TODO: make ajax call - this functionality is not used in the site yet so its not written yet...
      format.js
    end
  end

  
  ######################################################
  ## BEGIN PRIVATE METHODS
  ######################################################
  private
  
  def get_friends_ideas(stream_view, ideas_per_page, current_page)
    # TODO: public ideas that don't have any subscribers are not displayed
    #       figure out a good way to integrate these
    page_number = current_page || 1
    User.get_my_friends_ideas(current_user, ideas_per_page, page_number)
  end
  
  def search_ideas(search_string, ideas_per_page, current_page)
    if search_string == INPUT_BOX_SEARCH_IDEAS
      search_string = ""
    end

    page_number = 1    
    unless current_page.nil? || current_page.blank?
      page_number = current_page.to_i
    end
 
    if search_string.nil? || search_string.empty?
      return Idea.limit(ideas_per_page).offset((page_number-1)*ideas_per_page).order("num_users_joined DESC")
    else
    
      @search = Idea.search do
        fulltext search_string.to_s, :minimum_match => 1
        order_by :num_users_joined, :desc
        paginate :page => page_number, :per_page => ideas_per_page
      end
      
      @search.results
    end

  end

end
