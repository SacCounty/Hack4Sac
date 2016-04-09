class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_one :response, dependent: :destroy
end
