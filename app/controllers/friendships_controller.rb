class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # Called from "add friend" link
  # Routes back to user list view
  def create
    @friendship = current_user.friendships.build
    @friendship.friend_id = params[:friend_id]
    
    # TODO: flash doesn't work with AJAX request?
    if @friendship.save
      flash[:notice] = 'Friendship was successfully created.'
    else
      flash[:error] = 'Error creating friendship'
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
      #format.json { render json: @friendship }
    end

  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friend = @friendship.friend
    @friendship.destroy

    flash[:notice] = "Removed friendship."
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      #format.json { render json: @friendship }
    end
  end
end
