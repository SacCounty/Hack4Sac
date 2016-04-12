class UsersQuestionnairesController < ApplicationController
  def edit
    @questionnaire = Questionnaire.find(questionnaire_params)
  end

  def update
    response_params['questions'].each do |question_id, response_hash|
      question_response = Response.find_or_initialize_by(
        user_id: current_user.id,
        question_id: question_id
      )
      question_response.update(response_text: response_hash['response'])
    end

    redirect_to user_path(current_user)
  end

  private
    def questionnaire_params
      params.require(:id)
    end

    def response_params
      params.require(:questionnaire).permit(:questions => [:id, :response])
    end
end
