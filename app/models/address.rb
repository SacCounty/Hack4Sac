class Address < ActiveRecord::Base
  has_many :user_addresses, dependent: :destroy
  has_many :users, through: :user_addresses

  validates :street_address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :phone, presence: true
end
