class RemoveDefaultValueFromApprovalStatus < ActiveRecord::Migration
  def change
    remove_column :donation_applications, :approval_status
    add_column :donation_applications, :approval_status, :string
  end
end
