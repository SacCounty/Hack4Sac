class CreateDonationApplicationTrackers < ActiveRecord::Migration
  def change
    create_table :donation_application_trackers do |t|
      t.belongs_to :user, null: false
      t.belongs_to :listing, null: false
      t.datetime :submission_date
      t.string :approval_status, default: "not seen"
      t.text :approval_status_reason
      t.timestamps null: false
    end
  end
end
