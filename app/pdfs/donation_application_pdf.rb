class DonationApplicationPdf < FillablePdfForm

  def initialize(user, address, listing, user_q)
    @user = user
    @address = address
    @listing = listing
    @user_q = user_q
    super()
  end

  protected

  def fill_out
    not_applicable = 'N/A'

    if @user.type.organization # or @user.type == 'organization'
      # `user.questionnaires.where(name: "organization").first.questions.where(question_text: "School District Name").first.response.response_text`
      questionnaire = @user.questionnaires.where(name: 'organization')

      fill :name, @user.entity_name
      fill :contact_name, questionnaire.questions.where(question_text: 'Organization Contact Name')

      fill :public_benefits_no, 'No'
      fill :public_benefits_yes, 'Off'

      fill :tax_exempt_no, case questionnaire.questions.where(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                             when nil then
                               'Off'
                             when 'Yes' then
                               'Off'
                             else
                               'No'
                           end

      fill :tax_exempt_yes, case questionnaire.questions.where(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                              when nil then
                                'Off'
                              when 'No' then
                                'Off'
                              else
                                'Yes'
                            end

      fill :school_district_name, case questionnaire.questions.where(question_text: 'School District Name').response.response_text
                                    when nil then
                                      'N/A'
                                    else
                                      questionnaire.questions.where(question_text: 'School District Name').response.response_text
                                  end

      fill :school_district_no, case questionnaire.questions.where(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                  when nil then
                                    'Off'
                                  when 'Yes' then
                                    'Off'
                                  else
                                    'No'
                                end

      fill :school_district_yes, case questionnaire.questions.where(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                   when nil then
                                     'Off'
                                   when 'No' then
                                     'Off'
                                   else
                                     'Yes'
                                 end

      fill :special_district_name, case questionnaire.questions.where(question_text: 'Special District Name').response.response_text
                                     when nil then
                                       'N/A'
                                     else
                                       questionnaire.questions.where(question_text: 'Special District Name').response.response_text
                                   end

      fill :special_district_no, case questionnaire.questions.where(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                   when nil then
                                     'Off'
                                   when 'Yes' then
                                     'Off'
                                   else
                                     'No'
                                 end

      fill :special_district_yes, case questionnaire.questions.where(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                    when nil then
                                      'Off'
                                    when 'No' then
                                      'Off'
                                    else
                                      'Yes'
                                  end
    elsif @user.type.individual # or @user.type == 'individual'
      questionnaire = @user.questionnaires.where(name: 'individual')

      fill :name, @user.name

      [:contact_name, :school_district_name, :special_district_name].each do |field|
        fill field, not_applicable
      end

      [:tax_exempt_no, :school_district_no, :special_district_no].each do |field|
        fill field, 'No'
      end

      [:tax_exempt_yes, :school_district_yes, :special_district_yes].each do |field|
        fill field, 'Off'
      end

      if questionnaire.questions.where(question_text: 'Are you receiving CalFresh benefits?').response.response_text.to_s.downcase == 'yes' or
          questionnaire.questions.where(question_text: 'Are you receiving CalWORKS benefits?').response.response_text.to_s.downcase == 'yes' or
          questionnaire.questions.where(question_text: 'Are you receiving County Relief benefits?').response.response_text.to_s.downcase == 'yes' or
          questionnaire.questions.where(question_text: 'Are you receiving General Relief benefits?').response.response_text.to_s.downcase == 'yes' or
          questionnaire.questions.where(question_text: 'Are you receiving General Assistance benefits?').response.response_text.to_s.downcase == 'yes' or
          questionnaire.questions.where(question_text: 'Are you receiving MediCal benefits?').response.response_text.to_s.downcase == 'yes'
        public_benefits_yes = 'Yes'
        public_benefits_no = 'Off'
      else
        public_benefits_yes = 'Off'
        public_benefits_no = 'No'
      end

      fill :public_benefits_no, public_benefits_no
      fill :public_benefits_yes, public_benefits_yes
    end

    fill :applicant_name, @user.name

    [:sign_date, :application_date].each do |field|
      fill field, Date.today.to_s
    end

    [:city, :phone, :fax].each do |field|
      fill field, @address.send(field)
    end

    state_zip_code = @address.state.to_s + ' ' + @address.zip_code.to_s
    fill :state_zip, state_zip_code

    true
  end

end
