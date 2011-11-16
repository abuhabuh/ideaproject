class IdeaDealsController < ApplicationController
  # GET /idea_deals
  # GET /idea_deals.json
  def index
    @idea_deals = IdeaDeal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @idea_deals }
    end
  end

  # GET /idea_deals/1
  # GET /idea_deals/1.json
  def show
    @idea_deal = IdeaDeal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea_deal }
    end
  end

  # GET /idea_deals/new
  # GET /idea_deals/new.json
  def new
    @idea_deal = IdeaDeal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea_deal }
    end
  end

  # GET /idea_deals/1/edit
  def edit
    @idea_deal = IdeaDeal.find(params[:id])
  end

  # POST /idea_deals
  # POST /idea_deals.json
  def create

    if params[:idea_deal] && !params[:idea_deal].blank?
      # coming in from regular http post request
      @idea_deal = IdeaDeal.new(params[:idea_deal])
    else
      # coming in from ajax request from idea view page's show.html.erb
      @idea_deal = IdeaDeal.new
      @idea_deal.idea_id = params[:idea_id]
      @idea_deal.deal_id = params[:deal_id]
    end

    respond_to do |format|
      if @idea_deal.save
        format.html { redirect_to @idea_deal, notice: 'Idea deal was successfully created.' }
        #format.json { render json: @idea_deal, status: :created, location: @idea_deal }
        format.js
      else
        format.html { render action: "new" }
        #format.json { render json: @idea_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /idea_deals/1
  # PUT /idea_deals/1.json
  def update
    @idea_deal = IdeaDeal.find(params[:id])

    respond_to do |format|
      if @idea_deal.update_attributes(params[:idea_deal])
        format.html { redirect_to @idea_deal, notice: 'Idea deal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea_deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idea_deals/1
  # DELETE /idea_deals/1.json
  def destroy
    @idea_deal = IdeaDeal.find(params[:id])
    @idea_deal.destroy

    respond_to do |format|
      format.html { redirect_to idea_deals_url }
      format.json { head :ok }
    end
  end
end
