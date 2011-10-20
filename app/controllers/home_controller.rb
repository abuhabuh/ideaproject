class HomeController < ApplicationController



  def index
    # User hits index controller as authenticated or as unauthenticated
    #   1. Unauthenticated users taken to index page with idea input
    #   2. Authenticated users taken to main home page
    if user_signed_in?
      puts "******** SIGNED IN **********"
      redirect_to :action => :authenticated_home
    else
      puts "******** Not SIGNED IN *********"
    end
  end

  
  def authenticated_home
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
    
  end




end
