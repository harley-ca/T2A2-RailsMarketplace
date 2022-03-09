json.extract! listing, :id, :title, :type, :game, :description, :status, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
