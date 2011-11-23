class UserIdeaTimesController < ApplicationController
  # GET /user_idea_times
  # GET /user_idea_times.json
  def index
    @user_idea_times = UserIdeaTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_idea_times }
    end
  end

  # GET /user_idea_times/1
  # GET /user_idea_times/1.json
  def show
    @user_idea_time = UserIdeaTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_idea_time }
    end
  end

  # GET /user_idea_times/new
  # GET /user_idea_times/new.json
  def new
    @user_idea_time = UserIdeaTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_idea_time }
    end
  end

  # GET /user_idea_times/1/edit
  def edit
    @user_idea_time = UserIdeaTime.find(params[:id])
  end

  # POST /user_idea_times
  # POST /user_idea_times.json
  def create
    @user_idea_time = UserIdeaTime.new(params[:user_idea_time])

    respond_to do |format|
      if @user_idea_time.save
        format.html { redirect_to @user_idea_time, notice: 'User idea time was successfully created.' }
        format.json { render json: @user_idea_time, status: :created, location: @user_idea_time }
      else
        format.html { render action: "new" }
        format.json { render json: @user_idea_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_idea_times/1
  # PUT /user_idea_times/1.json
  def update
    @user_idea_time = UserIdeaTime.find(params[:id])

    respond_to do |format|
      if @user_idea_time.update_attributes(params[:user_idea_time])
        format.html { redirect_to @user_idea_time, notice: 'User idea time was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_idea_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_idea_times/1
  # DELETE /user_idea_times/1.json
  def destroy
    @user_idea_time = UserIdeaTime.find(params[:id])
    @user_idea_time.destroy

    respond_to do |format|
      format.html { redirect_to user_idea_times_url }
      format.json { head :ok }
    end
  end
end
