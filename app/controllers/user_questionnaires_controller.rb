class UserQuestionnairesController < ApplicationController
  before_action :authenticate_user!

  def show
    @questionnaire = Questionnaire.find_by(name: current_user.account_type)
  end

  def new
    @questionnaire = Questionnaire.find_by(name: current_user.account_type)
  end

  def create
    #
  end
end