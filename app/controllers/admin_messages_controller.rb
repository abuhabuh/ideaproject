class AdminMessagesController < ApplicationController
  # GET /admin_messages
  # GET /admin_messages.json
  def index
    @admin_messages = AdminMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_messages }
    end
  end

  # GET /admin_messages/1
  # GET /admin_messages/1.json
  def show
    @admin_message = AdminMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_message }
    end
  end

  # GET /admin_messages/new
  # GET /admin_messages/new.json
  def new
    @admin_message = AdminMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_message }
    end
  end

  # GET /admin_messages/1/edit
  def edit
    @admin_message = AdminMessage.find(params[:id])
  end

  # POST /admin_messages
  # POST /admin_messages.json
  def create
    @admin_message = AdminMessage.new(params[:admin_message])

    respond_to do |format|
      if @admin_message.save!
        format.html { redirect_to :back }
        #format.json { render json: @admin_message, status: :created, location: @admin_message }
        format.js
      else
        # TODO: Handle save error
        format.html { render action: "new" }
        #format.json { render json: @admin_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin_messages/1
  # PUT /admin_messages/1.json
  def update
    @admin_message = AdminMessage.find(params[:id])

    respond_to do |format|
      if @admin_message.update_attributes(params[:admin_message])
        format.html { redirect_to @admin_message, notice: 'Admin message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_messages/1
  # DELETE /admin_messages/1.json
  def destroy
    @admin_message = AdminMessage.find(params[:id])
    @admin_message.destroy

    respond_to do |format|
      format.html { redirect_to admin_messages_url }
      format.json { head :ok }
    end
  end
end
