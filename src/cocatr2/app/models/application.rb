class Application < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  enum application_type: { "Application" => 0, "Report" => 1 }
  enum status: { "Draft" => 0, "Pending" => 1, "Approved" => 2, "Declined" => 3, "Open" => 4, "Archived" => 5, "Closed" => 6 }

end
