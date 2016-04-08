class UsersAddress < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :address, dependent: :destroy
end
