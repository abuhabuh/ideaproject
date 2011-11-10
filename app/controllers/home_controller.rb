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
    @initial_idea = nil
    if session[:initial_idea] && !session[:initial_idea].blank?
      # Pass idea to view
      @initial_idea = session[:initial_idea]
      
      # Delete idea from session
      session.delete(:initial_idea)
      if session[:initial_idea]
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
    
    # Gets collections of user ideas, friends' ideas
    set_objs_to_render

#    if params[:search] && !params[:search].blank?

    @search_result_ideas = search_ideas(params[:search], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
#    else
      # Get stream ideas based on what type of stream we're rendering: Public, 
      #   Friends, etc. Default is public view.
    @friends_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
#    end
  end


  # Renders JS for appending additional stream content to auth home stream
  # - works for friends ideas and search ideas
  # - need to have :page parameter is passed in and :stream_view is in session
  # TODO: Call from jquery.ajax() data type is HTML, but still JS call so these js files that are rendered
  #   are returning HTML. Make sure this is right
  def next_ideas_batch_js
    session[:page] = params[:page] # session[:page] written to hidden div to support ajax

    set_objs_to_render

    respond_to do |format|
      # JS is the only format that this function should be called as
      format.js {
        if session[:stream_view] == STREAM_VIEW_FRIENDS
          @friends_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          render "next_friends_ideas_batch.js.erb" # NOTE: PICTURE VIEW MODE is set to view PIC_VIEW_TYPE_USER in js.erb
        else
          @search_result_ideas = search_ideas(params[:idea], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          render "next_search_ideas_batch.js.erb" # NOTE: PICTURE VIEW MODE is set to view PIC_VIEW_TYPE_USER in js.erb
        end
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
      session[:initial_idea] = params[:idea]
      
      @search_result_ideas = search_ideas(params[:idea], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
      @user_idea_ids = Array.new # empty array for user ideas since the user is unauthenticated
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
       
    respond_to do |format|
      format.html {
        set_objs_to_render

        if params[:search] && !params[:search].blank?

          @search_result_ideas = search_ideas(params[:search], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          
        else
          # Get stream ideas based on what type of stream we're 
          #   rendering: Public, Friends, etc. Default is public view.
          @friends_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          
        end

        redirect_to authenticated_home_path
      }
      # TODO: make ajax call
      format.js
    end
  end


  # Joins user to existing idea
  # Doesn't create new idea object
  # TODO make this ajax call
  def add_idea_id
    if params[:idea_id] && !params[:idea_id].blank?
      @idea = Idea.find(params[:idea_id])
      current_user.join_idea(@idea.id)
    else
      # Handle unexpected nil error
      puts " TRACE HomeController:add_idea_id - no param for idea"
    end
    
    respond_to do |format|
      format.html {
        set_objs_to_render

        if params[:search] && !params[:search].blank?
          
          @search_result_ideas = search_ideas(params[:search], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
          
        else
          # Get stream ideas based on what type of stream we're 
          #   rendering: Public, Friends, etc. Default is public view.
          @friends_ideas = get_friends_ideas(session[:stream_view], AUTH_HOME_IDEAS_PER_PAGE, params[:page])
        end

        redirect_to authenticated_home_path
      }
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
  
  def set_objs_to_render()
    @user_ideas = User.get_my_ideas(current_user)
    @user_idea_ids = User.get_my_idea_ids(current_user)
  end

  def search_ideas(search_string, ideas_per_page, current_page)

    page_number = current_page || 1
    @search = Idea.search do
      fulltext search_string.to_s, :minimum_match => 1
      order_by :num_users_joined, :desc
      paginate :page => page_number, :per_page => ideas_per_page
    end
    
    @search.results

  end

end
