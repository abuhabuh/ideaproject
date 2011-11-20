class IdeaEventsController < ApplicationController
  # GET /idea_events
  # GET /idea_events.json
  def index
    @idea_events = IdeaEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @idea_events }
    end
  end

  # GET /idea_events/1
  # GET /idea_events/1.json
  def show
    @idea_event = IdeaEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea_event }
    end
  end

  # GET /idea_events/new
  # GET /idea_events/new.json
  def new
    @idea_event = IdeaEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea_event }
    end
  end

  # GET /idea_events/1/edit
  def edit
    @idea_event = IdeaEvent.find(params[:id])
  end

  # POST /idea_events
  # POST /idea_events.json
  def create
    @idea_event = IdeaEvent.new(params[:idea_event])

    respond_to do |format|
      if @idea_event.save
        format.html { redirect_to @idea_event, notice: 'Idea event was successfully created.' }
        format.json { render json: @idea_event, status: :created, location: @idea_event }
      else
        format.html { render action: "new" }
        format.json { render json: @idea_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /idea_events/1
  # PUT /idea_events/1.json
  def update
    @idea_event = IdeaEvent.find(params[:id])

    respond_to do |format|
      if @idea_event.update_attributes(params[:idea_event])
        format.html { redirect_to @idea_event, notice: 'Idea event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idea_events/1
  # DELETE /idea_events/1.json
  def destroy
    @idea_event = IdeaEvent.find(params[:id])
    @idea_event.destroy

    respond_to do |format|
      format.html { redirect_to idea_events_url }
      format.json { head :ok }
    end
  end
end
