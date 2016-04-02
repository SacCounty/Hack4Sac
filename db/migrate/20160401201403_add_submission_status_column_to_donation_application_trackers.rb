class AddSubmissionStatusColumnToDonationApplicationTrackers < ActiveRecord::Migration
  def change
    add_column :donation_application_trackers, :submission_status, :string
  end
end
