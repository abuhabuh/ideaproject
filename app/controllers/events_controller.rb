class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    @idea = Idea.find(params[:idea_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @idea = @event.idea
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    # Make picture
    @picture = Picture.new
    unless params[:internet_url_path].empty?
      @picture.set_photo_from_url(params[:internet_url_path])
    end
    unless params[:picture].nil?
      @picture.picture = params[:picture]
    end

    unless @picture.save!
      puts " TRACE: EventsController:create - saving picture failed"
    end

    respond_to do |format|
      if @event.save
      
        # Link picture to event 
        @event_picture = EventPicture.new
        @event_picture.event_id = @event.id
        @event_picture.picture_id = @picture.id
        
        unless @event_picture.save!
          puts " TRACE: EventsController:create - saving event picture link failed"
        end

        # Create user_event object with status of owner
        unless UserEvent.create!(:user_id => current_user.id, :event_id => @event.id, :status => USER_EVENT_STATUS_ADMIN)
          puts " TRACE: EventsController:create - error creating UserEvent object"
        end
      
        unless IdeaEvent.create!(:idea_id => params[:idea_id], :event_id => @event.id)
          puts " TRACE: EventsController:create - error creating IdeaEvent object"
        end
      
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    # set picture if input
    @picture = @event.pictures.first
    unless params[:internet_url_path].empty?
      @picture.set_photo_from_url(params[:internet_url_path])
    end
    unless params[:picture].nil?
      #TODO: NOT SAVING RIGHT
      @picture.picture = params[:picture]
    end

    unless @picture.save
      puts " TRACE: EventsController:update - picture update failed"
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
end
