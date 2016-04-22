class Address < ActiveRecord::Base
  belongs_to :user

  validates :street_address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
