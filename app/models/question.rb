class Question < ActiveRecord::Base
  belongs_to :questionnaire, dependent: :destroy
  has_one :response
  accepts_nested_attributes_for :response
end
