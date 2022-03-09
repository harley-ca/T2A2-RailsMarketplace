class Listing < ApplicationRecord
  belongs_to :user

  enum listing_type: [:coach, :offer, :request, :trade]
  enum status: [:draft, :sent, :archived, :accepted, :declined, :open, :closed]
end
