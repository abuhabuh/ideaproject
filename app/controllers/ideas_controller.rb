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
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
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



  # POST /ideas/add_idea
  def add_idea
    if params[:idea] && !params[:idea].blank?
      current_user.create_idea(params[:idea])
    else
      # Handle unexpected nil error
      puts " TRACE IdeasController:add_idea - no param for idea"
    end

    render 'home/authenticated_home'
  end

  # POST /ideas/process_idea
  def process_idea

    # TODO: validate :idea parameter on client side through
    #   form validation
    if params[:idea] && !params[:idea].blank?
      @ideaText = params[:idea]
      
      # Add string to session to save for when user
      #   authenticates
      session[:initial_idea] = params[:idea]
      
      # Do matching on ideaText to list top similar ideas
      #   Create idea object and call idea.getmatches

      # Forward to process_idea view page to show results
      #   and incentivize to sign up
    else
      # Handle unexpected nil error
      puts " TRACE IdeasController:process_idea - no param for idea"
    end

    render 'home/process_idea'
  end


  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

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

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
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
end
