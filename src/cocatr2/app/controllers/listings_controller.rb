class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy update_listing ]
  before_action :authenticate_user! , only: [:new, :create, :destroy, :my_listings]

  # This modified index method accepts search params
  def index
    @listings = Listing.filter_by(params.slice(:title, :username)).filter_by_status("Open")
  end

  def my_listings
    @listings = Listing.filter_by_user(current_user)
  end

  # GET /listings/1 or /listings/1.json
  def show
    @applications = @listing.applications.filter_by_status("Pending").filter_by_application_type("Application")
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end



  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_listing
    @listing.update(status: params[:status])
    redirect_to listing_url(@listing)
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_status_param)
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :listing_type, :game, :description, :status, :user_id, :listing_picture)
    end

    def listing_status_param
      params.require(:status)
    end
end
