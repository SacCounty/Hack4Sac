class UsersQuestionnairesController < ApplicationController
  before_action :get_questionnaire

  def edit
    #
  end

  def update
    #
  end

  private
    def get_questionnaire
      @questionnaire = Questionnaire.find_by(name: current_user.account_type)
    end

    # TODO: remove this, maybe just get a map of ???
    def get_application_questionnaire_responses
      @application_questionnaire_responses = @questionnaire.questions.map { |q|
        response = ''
        response = q.response.response_text if q.response
        [q.question_text, response]
      }.to_h
    end
end