class UsersQuestionnairesController < ApplicationController
  before_action :get_questionnaire
  before_action :user_questionnaire_params, only: [:create, :update]
  before_action :get_questionnaire_responses, only: :edit

  def edit
    #
  end

  def new
    #
  end

  def create
    successful_saves = 0

    user_questionnaire_params['questions'].each do |question_id, response_hash|
      if response_hash['response'].nil? or response_hash['response'] == ''
        response_hash['response'] = 'Respondent did not answer'
      end

      question_response = Response.new(question_id: question_id,
                                       user_id: current_user.id,
                                       response_text: response_hash['response'])

      if question_response.save
        successful_saves += 1
      end

    end

    if successful_saves >= user_questionnaire_params['questions'].length
      flash[:success] = 'Your questionnaire has been updated!'
    else
      flash[:danger] = 'One or more questions were not updated, please try again!'
    end

    redirect_to user_path(current_user)
  end

  def update
    successful_saves = 0

    user_questionnaire_params['questions'].each do |question_id, response_hash|
      question_response = Response.find_by(user_id: current_user.id, question_id: question_id)
      question_response.response_text = response_hash['response']

      if question_response.save
        successful_saves += 1
      end
    end

    if successful_saves >= user_questionnaire_params['questions'].length
      flash[:success] = 'Your questionnaire has been updated!'
    else
      flash[:danger] = 'One or more questions were not updated, please try again!'
    end

    redirect_to user_path(current_user)
  end

  private
  def get_questionnaire
    @questionnaire = Questionnaire.find_by(name: current_user.account_type)
  end

  def get_questionnaire_responses
    @questionnaire_responses = @questionnaire.questions.map { |q|
      response = ''
      response = q.response.response_text if q.response
      [q.id, [q.question_text, q.question_type, response]]
    }.to_h
  end

  def user_questionnaire_params
    params.require(:questionnaire).permit(:questions => [:id, :response])
  end

end
