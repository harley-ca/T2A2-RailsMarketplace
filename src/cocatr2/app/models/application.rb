class Application < ApplicationRecord
include Filterable
  belongs_to :user
  belongs_to :listing

  # Enums define what the integer values mean, and provide an alternate way to use them.
  enum application_type: { "Application" => 0, "Report" => 1 }
  enum status: { "Draft" => 0, "Pending" => 1, "Approved" => 2, "Declined" => 3, "Open" => 4, "Archived" => 5, "Closed" => 6 }

  # Scopes for searching
  scope :filter_by_application_type, -> (application_type) {where application_type: application_type}
  scope :filter_by_status, -> (status) {where status: status}
  scope :filter_by_listing, -> (listing) {where listing: listing}
  scope :filter_by_user, -> (user) {where("user like ?", "#{user}")}
end
