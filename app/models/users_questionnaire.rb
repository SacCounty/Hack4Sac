class UsersQuestionnaire < ActiveRecord::Base
  belongs_to :user
  belongs_to :questionnaire
end
