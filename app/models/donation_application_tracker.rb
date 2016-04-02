class DonationApplicationTracker < ActiveRecord::Base
  belongs_to :applicant, class_name: "User", foreign_key: "user_id"
  belongs_to :listing
end
