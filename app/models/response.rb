class Response < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :question, dependent: :destroy
end
