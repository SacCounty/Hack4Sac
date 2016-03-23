class FollowedListing < ActiveRecord::Base
  belongs_to :follower, class_name: "User", foreign_key: "user_id"
  belongs_to :listing
end
