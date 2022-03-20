class ApplicationsController < ApplicationController
    before_action :find_listing, except: [:my_apps]
    before_action :authenticate_user!
    before_action :find_app, only: [:update_app]

    def index
        @applications = Application.filter_by(params.slice(:listing, :status, :application_type, :user))
    end

    def my_apps
        @applications = Application.filter_by_user(current_user).filter_by_application_type("Application")
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


    def update_app
        @application.update(status: params[:status])
        redirect_to listing_url(@listing)
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
        def find_app
            @application = Application.find(params[:id])
        end
end