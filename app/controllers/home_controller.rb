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
    set_objs_to_render()

    if params[:search] && !params[:search].blank?

      @search = Idea.search do
        fulltext params[:search]
        order_by :num_users_joined, :desc
      end
      @idea_search_res = @search.results
      
    else
      # Get stream ideas based on what type of stream we're rendering: Public, 
      #   Friends, etc. Default is public view.
      @stream_ideas = get_stream_ideas(session[:stream_view])
    end
  end


  # IMPLEMENTED
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
      
      @search = Idea.search do
        keywords params[:idea]
        order_by :num_users_joined, :desc
        paginate :page => 1, :per_page => 5
      end
      @idea_search_res = @search.results
      
      puts "******* idea res size: " + @idea_search_res.size.to_s
      
    else
      # Handle unexpected nil error
      puts " TRACE IdeasController:process_idea - no param for idea"
    end
    
  end


  # IMPLEMENTED
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
        set_objs_to_render(session[:stream_view])
        redirect_to authenticated_home_path
      }
      # TODO: make ajax call
      format.js
    end
  end

  # IMPLEMENTED
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
        set_objs_to_render(session[:stream_view])
        redirect_to authenticated_home_path
      }
      format.js
    end
  end



  
  ######################################################
  ## BEGIN PRIVATE METHODS
  ######################################################
  private
  
  def get_stream_ideas(stream_view)
    # TODO: public ideas that don't have any subscribers are not displayed
    #       figure out a good way to integrate these
    unless stream_view.blank?
 
      case stream_view.to_s
        when STREAM_VIEW_FRIENDS
          return User.get_my_friends_ideas(current_user)
        else STREAM_VIEW_PUBLIC
          return User.get_public_ideas
      end
      
    else
      # TODO: catch error / throw error - stream_view type not specified
      #  OR this should default to public view
      puts "error"
    end
  end
  
  def set_objs_to_render()
    @user_ideas = User.get_my_ideas(current_user)
    @user_idea_ids = User.get_my_idea_ids(current_user)
  end

end
