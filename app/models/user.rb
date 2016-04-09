class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :users_questionnaires, dependent: :destroy
  has_many :questionnaires, through: :users_questionnaires
  has_many :addresses, dependent: :destroy
  has_many :contact_infos, dependent: :destroy
  has_many :listings
  has_many :followed_listings, dependent: :destroy
  has_many :donation_applications, dependent: :destroy
end
