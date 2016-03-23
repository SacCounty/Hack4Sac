class UsersQuestionnaire < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :questionnaire, dependent: :destroy
end
