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
    fill :name, case @user.entity_name
                  when nil then
                    @user.name
                  else
                    @user.entity_name
                end

    fill :applicant_name, @user.name

    fill :contact_name, @user_q.questionnaire.questions.find(question_text: 'Organization Contact Name').response.response_text

    [:sign_date, :application_date].each do |field|
      fill field, Date.today.to_s
    end

    [:city, :phone, :fax].each do |field|
      fill field, @address.send(field)
    end

    state_zip_code = 'CA 95616' #@address.state.to_s + ' ' + @address.zip_code.to_s
    fill :state_zip, state_zip_code

    fill :tax_exempt_no, case @user_q.questionnaire.questions.find(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                           when nil then
                             'Off'
                           when 'Yes' then
                             'Off'
                           else
                             'No'
                         end

    fill :tax_exempt_yes, case @user_q.questionnaire.questions.find(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                            when nil then
                              'Off'
                            when 'No' then
                              'Off'
                            else
                              'Yes'
                          end

    fill :school_district_name, case @user_q.questionnaire.questions.find(question_text: 'School District Name').response.response_text
                                  when nil then
                                    ''
                                  else
                                    @user_q.questionnaire.questions.find(question_text: 'School District Name').response.response_text
                                end

    fill :school_district_no, case @user_q.questionnaire.questions.find(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                when nil then
                                  'Off'
                                when 'Yes' then
                                  'Off'
                                else
                                  'No'
                              end

    fill :school_district_yes, case @user_q.questionnaire.questions.find(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                 when nil then
                                   'Off'
                                 when 'No' then
                                   'Off'
                                 else
                                   'Yes'
                               end

    fill :special_district_name, case @user_q.questionnaire.questions.find(question_text: 'Special District Name').response.response_text
                                   when nil then
                                     ''
                                   else
                                     @user_q.questionnaire.questions.find(question_text: 'Special District Name').response.response_text
                                 end

    fill :special_district_no, case @user_q.questionnaire.questions.find(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                 when nil then
                                   'Off'
                                 when 'Yes' then
                                   'Off'
                                 else
                                   'No'
                               end

    fill :special_district_yes, case @user_q.questionnaire.questions.find(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                  when nil then
                                    'Off'
                                  when 'No' then
                                    'Off'
                                  else
                                    'Yes'
                                end

    if @user_q.questionnaire.questions.find(question_text: 'Are you receiving CalFresh benefits?').response.response_text.to_s.downcase == 'yes' or
        @user_q.questionnaire.questions.find(question_text: 'Are you receiving CalWORKS benefits?').response.response_text.to_s.downcase == 'yes' or
        @user_q.questionnaire.questions.find(question_text: 'Are you receiving County Relief benefits?').response.response_text.to_s.downcase == 'yes' or
        @user_q.questionnaire.questions.find(question_text: 'Are you receiving General Relief benefits?').response.response_text.to_s.downcase == 'yes' or
        @user_q.questionnaire.questions.find(question_text: 'Are you receiving General Assistance benefits?').response.response_text.to_s.downcase == 'yes' or
        @user_q.questionnaire.questions.find(question_text: 'Are you receiving MediCal benefits?').response.response_text.to_s.downcase == 'yes'
      public_benefits_yes = 'Yes'
      public_benefits_no = 'Off'
    else
      public_benefits_yes = 'Off'
      public_benefits_no = 'No'
    end

    fill :public_benefits_no, public_benefits_no

    fill :public_benefits_yes, public_benefits_yes

    true
  end

end
