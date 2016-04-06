class ChangeDonationApplicationTrackersToDonationApplications < ActiveRecord::Migration
  def change
    rename_table :donation_application_trackers, :donation_applications
  end
end
