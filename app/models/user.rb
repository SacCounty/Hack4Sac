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

  # TODO Refactor: a model instance should only know its own attributes and not depend on other model attributes
  def full_name
    name = self.entity_name

    unless name
      contact_info = self.contact_infos.find_by(primary: true)
      name = "#{contact_info.first_name} + #{contact_info.last_name}".strip.titleize if contact_info
      name ||= ''
    end

    name
  end

end
