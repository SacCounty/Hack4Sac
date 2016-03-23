class Address < ActiveRecord::Base
  has_many :user_addresses, dependent: :destroy
  has_many :users, through: :user_addresses
end
