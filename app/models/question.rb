class Question < ActiveRecord::Base
  belongs_to :questionnaire, dependent: :destroy
  has_one :response
end
