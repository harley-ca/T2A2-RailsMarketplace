class Listing < ApplicationRecord
include Filterable
include PgSearch::Model
  belongs_to :user
  has_many :reviews
  has_many :applications

  # Enums define what the integer values mean, and provide an alternate way to use them
  enum listing_type: { "Coach" => 0, "Offer" => 1, "Request" => 2, "Trade" => 3 }
  enum status: { "Open" => 0, "Closed" => 1, "Archived" => 2, "Removed" => 3}

  # pg_search scope to be a bit more flexible for the search bar
  pg_search_scope :filter_by_title, against: :title

  # Regular scopes for assorted views
  scope :filter_by_status, -> (status) {where status: status}
  scope :filter_by_listing_type, -> (listing_type) {where listing_type: listing_type}
  scope :filter_by_username, -> (username) { joins(:user).where('username like ?', "#{username}")}

  # Get the average rating of all reviews left on this listing
  def average_rating
    if self.reviews.count == 0
      return 0
    end
    rating_sum = 0.0
    self.reviews.each do |r|
      rating_sum += r.rating.to_f
    end
    return rating_sum / self.reviews.count
  end

end
