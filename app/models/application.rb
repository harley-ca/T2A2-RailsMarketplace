class Application < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  # Enums define what the integer values mean, and provide an alternate way to use them.
  enum application_type: { "Application" => 0, "Report" => 1 }
  enum status: { "Draft" => 0, "Pending" => 1, "Approved" => 2, "Declined" => 3, "Open" => 4, "Archived" => 5, "Closed" => 6 }

end
