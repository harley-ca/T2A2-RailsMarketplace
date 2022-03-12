class ReviewsController < ApplicationController
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
        Review.create(title: review_params[:title], description: review_params[:description], rating: review_params[:rating], listing: @listing, user: current_user)
        redirect_to listing_path(@listing.id)
    end

    def review_params
        params.require(:review).permit(:title, :description, :rating, :user_id, :listing_id )
    end
 
end