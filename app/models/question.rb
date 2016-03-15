class Question < ActiveRecord::Base
  belongs_to :questionnaire, dependent: :destroy
  has_many :responses
end
