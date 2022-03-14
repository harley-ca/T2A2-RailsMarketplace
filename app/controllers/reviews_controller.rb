class ReviewsController < ApplicationController
    before_action :find_listing
    before_action :find_review, only: [:edit, :destroy, :update]
    before_action :authenticate_user! , only: [:new, :create, :edit, :destroy, :update]



    def index
        @reviews = @listing.reviews.all
    end

    # Initialises a new review belonging to the loaded listing
    def new
        @review = @listing.reviews.new
    end

    def edit
    end

    def destroy
        @review.destroy
    
        respond_to do |format|
          format.html { redirect_to listing_url, notice: "Your review was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    

    # Creates the new review
    def create
        Review.create(title: review_params[:title], description: review_params[:description], rating: review_params[:rating], listing: @listing, user: current_user)
        redirect_to listing_path(@listing.id)
    end
    # This doesn't work, not sure why
    def update
        @review.update(review_params)
        redirect_to listing_review_path(@listing.id), notice: "Review for #{@listing.title} was updated successfully"
    end
    private
        # Find methods to ensure relevant objects are loaded
        def find_listing
            @listing = Listing.find(params[:listing_id])
        end
        def find_review
            @review = @listing.reviews.find(params[:id])
        end
        # Defines and whitelists the parameters
        def review_params
            params.require(:review).permit(:title, :description, :rating, :user_id, :listing_id )
        end
end