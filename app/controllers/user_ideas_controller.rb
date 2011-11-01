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

  # POST /user_ideas
  # POST /user_ideas.json
  def create
    @user_idea = UserIdea.new(params[:user_idea])

    respond_to do |format|
      if @user_idea.save
        format.html { redirect_to @user_idea, notice: 'User idea was successfully created.' }
        format.json { render json: @user_idea, status: :created, location: @user_idea }
      else
        format.html { render action: "new" }
        format.json { render json: @user_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_ideas/1
  # PUT /user_ideas/1.json
  def update
    @user_idea = UserIdea.find(params[:id])

    respond_to do |format|
      if @user_idea.update_attributes(params[:user_idea])
        format.html { redirect_to @user_idea, notice: 'User idea was successfully updated.' }
        format.json { head :ok }
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
    @user_idea.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
end
