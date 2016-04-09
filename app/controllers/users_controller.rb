class UsersController < ApplicationController
  def show
    unless current_user
      redirect_to root_path and return
    end

    @user = User.find(params[:id])
    if current_user && (current_user == @user)
      @addresses = current_user.addresses
      @questionnaire = Questionnaire.find_by(name: current_user.account_type)

      # TODO Refactor N+1 query for response
      @application_questionnaire_responses = @questionnaire.questions.map { |q|
        response = ''
        response = q.response.response_text if q.response
        [q.question_text, response]
      }.to_h
      render 'users/show_as_owner' and return
    else
      redirect_to user_path(current_user)
      # render 'users/show_as_visitor' and return
    end
  end
end
