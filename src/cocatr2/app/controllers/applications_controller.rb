class ApplicationsController < ApplicationController
    before_action :find_listing
    before_action :authenticate_user! , only: [:new, :create, :destroy]

    def index
        @applications = Application.filter_by(params.slice(:listing, :status, :application_type, :user))
    end



    # Initialises a new review belonging to the loaded listing
    def new
        @application = @listing.applications.new
    end

    # Creates the new review
    def create
        Application.create(subject: application_params[:subject], message: application_params[:message], application_type: application_params[:application_type], status: 1, listing: @listing, user: current_user)
        redirect_to listing_path(@listing.id)
    end

    private
    
        # Loaded as a before action to ensure we have the relevant listing loaded
        def find_listing
            @listing = Listing.find(params[:listing_id])
        end
        # Defines and whitelists the params
        def application_params
            params.require(:application).permit(:subject, :message, :status, :application_type, :user_id, :listing_id)
        end
 
end