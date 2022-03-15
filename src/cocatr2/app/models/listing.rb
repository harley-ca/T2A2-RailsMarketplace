class Listing < ApplicationRecord
include Filterable
  belongs_to :user
  has_many :reviews
  has_many :applications

    # Enums define what the integer values mean, and provide an alternate way to use them.
  enum listing_type: { "Coach" => 0, "Offer" => 1, "Request" => 2, "Trade" => 3 }
  enum status: { "Open" => 0, "Closed" => 1, "Archived" => 2, "Removed" => 3}

  # Scopes for searching
  scope :filter_by_title, -> (title) {where("title like ?", "#{title}")}
  scope :filter_by_status, -> (status) {where status: status}
  scope :filter_by_listing_type, -> (listing_type) {where listing_type: listing_type}
  scope :filter_by_username, -> (username) { joins(:user).where('username like ?', "#{username}")}


end
