class Listing < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :applications

    # Enums define what the integer values mean, and provide an alternate way to use them.
  enum listing_type: { "Coach" => 0, "Offer" => 1, "Request" => 2, "Trade" => 3 }
  enum status: { "Open" => 0, "Closed" => 1, "Archived" => 2, "Removed" => 3}
end
