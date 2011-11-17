class DealsController < ApplicationController
  # GET /deals
  # GET /deals.json
  def index
  
    idea = Idea.find(params[:idea_id])
    
    puts "idea: " + idea.text
    idea_deals = idea.deals
    
    @idea_deal_ids = Array.new
    idea_deals.each do |idea_deal|
      @idea_deal_ids << idea_deal.id
    end

    current_page = params[:search_page_num].to_i || 1 # input should always be the right number but || 1 is safety
    search_object = search_deals(params[:search_text], current_page, DEALS_PER_PAGE) # TODO: results per page
    num_total_pages = 1 # init variable to default
    
    if search_object.total % DEALS_PER_PAGE > 0
      num_total_pages = search_object.total/DEALS_PER_PAGE + 1
    else
      num_total_pages = search_object.total/DEALS_PER_PAGE
    end
    @deals = search_object.results
    
    #end up with @deals collection
    
    respond_to do |format|
      format.html { render :partial => 'deal_search_results', 
                           :locals => {:current_page => current_page, 
                                       :num_total_pages => num_total_pages}
                  }
      #format.json { render json: @deals }
    end
    
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    # TODO: Cannot submit a file with AJAX so we are not allowing file uploads for deals right now
    #         and only allowing URL file retrievals. 
    #       Can follow tutorial using iframes and return_to_parent to do this in the future
    #         - http://khamsouk.souvanlasy.com/articles/ajax-file-uploads-in-rails-using-attachment_fu-and-responds_to_parent
    #
    
    @deal = Deal.new(params[:deal])

    unless params[:internet_url_path].empty?
      @deal.set_photo_from_url(params[:internet_url_path])
    end

    # Processing sanity check of incoming data before save
    #   Set user id of creating user
    @deal.user_id = current_user.id
    #   Set percentage off if original price is present
    unless @deal.original_price.nil?
      @deal.percent_off = ((@deal.original_price - @deal.price) / @deal.original_price) * 100
    end

    respond_to do |format|
      if @deal.save

        unless params[:idea_id] == 0
          @idea_deal = IdeaDeal.new
          @idea_deal.idea_id = params[:idea_id]
          @idea_deal.deal_id = @deal.id
          
          unless @idea_deal.save 
            puts " TRACE: DealsController:create - save error on idea deal object"
          end
        end

        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        #format.json { render json: @deal, status: :created, location: @deal } #TODO: figure out if we need to 
                                                                                  #render json  objects for everything
        format.js
      else
        format.html { render action: "new" }
        # format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :ok }
    end
  end




  ######################################################
  ## BEGIN PRIVATE METHODS
  ######################################################
  private
  
  # returns search object because we need to get total number of results for manual
  #   pagination: auto pagination with will_paginate is going to be a bitch to get 
  #   working with facebox cloning stuff
  def search_deals(search_string, page_number, deals_per_page)
    @search = Deal.search do
      fulltext search_string.to_s, :minimum_match => 1
      order_by :price, :asc
      paginate :page => page_number, :per_page => deals_per_page
    end
    
    @search
  end

end
