class UsersAddress < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
end
