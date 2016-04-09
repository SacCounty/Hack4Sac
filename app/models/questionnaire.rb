class Questionnaire < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :users_questionnaires, dependent: :destroy
  has_many :users, through: :users_questionnaire
end
