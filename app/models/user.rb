class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :users_questionnaires
  has_many :questionnaires, through: :users_questionnaires
  has_many :users_addresses
  has_many :addresses, through: :users_addresses
  has_many :listings
  has_many :followed_listings
  has_many :donation_applications
end
