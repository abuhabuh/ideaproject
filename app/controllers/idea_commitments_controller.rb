class IdeaCommitmentsController < ApplicationController
  # GET /idea_commitments
  # GET /idea_commitments.json
  def index
    @idea_commitments = IdeaCommitment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @idea_commitments }
    end
  end

  # GET /idea_commitments/1
  # GET /idea_commitments/1.json
  def show
    @idea_commitment = IdeaCommitment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea_commitment }
    end
  end

  # GET /idea_commitments/new
  # GET /idea_commitments/new.json
  def new
    @idea_commitment = IdeaCommitment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea_commitment }
    end
  end

  # GET /idea_commitments/1/edit
  def edit
    @idea_commitment = IdeaCommitment.find(params[:id])
  end

  # POST /idea_commitments
  # POST /idea_commitments.json
  def create
    @idea_commitment = IdeaCommitment.new(params[:idea_commitment])

    respond_to do |format|
      if @idea_commitment.save
        format.html { redirect_to @idea_commitment, notice: 'Idea commitment was successfully created.' }
        #format.json { render json: @idea_commitment, status: :created, location: @idea_commitment }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @idea_commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /idea_commitments/1
  # PUT /idea_commitments/1.json
  def update
    @idea_commitment = IdeaCommitment.find(params[:id])

    respond_to do |format|
      if @idea_commitment.update_attributes(params[:idea_commitment])
        format.html { redirect_to @idea_commitment, notice: 'Idea commitment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea_commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idea_commitments/1
  # DELETE /idea_commitments/1.json
  def destroy
    @idea_commitment = IdeaCommitment.find(params[:id])
    @idea_commitment.destroy

    respond_to do |format|
      format.html { redirect_to idea_commitments_url }
      format.json { head :ok }
    end
  end
end
