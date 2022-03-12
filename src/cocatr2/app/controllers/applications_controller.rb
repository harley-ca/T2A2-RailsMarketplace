class ApplicationsController < ApplicationController
    before_action :find_listing
    before_action :authenticate_user! , only: [:new, :create, :destroy]

    # Loaded as a before action to ensure we have the relevant listing loaded
    def find_listing
        @listing = Listing.find(params[:listing_id])
    end

    # Initialises a new review belonging to the loaded listing
    def new
        @review = @listing.reviews.new
    end

    # Creates the new review
    def create
        Application.create(subject: review_params[:subject], message: review_params[:message], application_type: review_params[:application_type], status: review_params[:status], listing: @listing, user: current_user)
        redirect_to listing_path(@listing.id)
    end

    def review_params
        params.require(:application).permit(:subject, :message, :status, :application_type)
    end
 
end