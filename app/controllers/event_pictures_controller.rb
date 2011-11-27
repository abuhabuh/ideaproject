class EventPicturesController < ApplicationController
  # GET /event_pictures
  # GET /event_pictures.json
  def index
    @event_pictures = EventPicture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_pictures }
    end
  end

  # GET /event_pictures/1
  # GET /event_pictures/1.json
  def show
    @event_picture = EventPicture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_picture }
    end
  end

  # GET /event_pictures/new
  # GET /event_pictures/new.json
  def new
    @event_picture = EventPicture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_picture }
    end
  end

  # GET /event_pictures/1/edit
  def edit
    @event_picture = EventPicture.find(params[:id])
  end

  # POST /event_pictures
  # POST /event_pictures.json
  def create
    @event_picture = EventPicture.new(params[:event_picture])

    respond_to do |format|
      if @event_picture.save
        format.html { redirect_to @event_picture, notice: 'Event picture was successfully created.' }
        format.json { render json: @event_picture, status: :created, location: @event_picture }
      else
        format.html { render action: "new" }
        format.json { render json: @event_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_pictures/1
  # PUT /event_pictures/1.json
  def update
    @event_picture = EventPicture.find(params[:id])

    respond_to do |format|
      if @event_picture.update_attributes(params[:event_picture])
        format.html { redirect_to @event_picture, notice: 'Event picture was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_pictures/1
  # DELETE /event_pictures/1.json
  def destroy
    @event_picture = EventPicture.find(params[:id])
    @event_picture.destroy

    respond_to do |format|
      format.html { redirect_to event_pictures_url }
      format.json { head :ok }
    end
  end
end
