class DonationApplicationPdf < FillablePdfForm

  def initialize(args = {})
    @user = args[:user]
    @listing = args[:listing]
    @user_questionnaire = Questionnaire.find_by(name: @user.account_type)
    @address = @user.addresses.first || {}
    @contact = @user.contact_infos.find_by(primary: true) || {}
    @contact_name = "#{@contact[:first_name]} #{@contact[:last_name]}"
    super()
  end

  protected

  def fill_out
    not_applicable = 'N/A'

    fill :date, Date.today.to_s

    if @user.account_type.downcase == 'organization'
      fill :name, @user.entity_name || @contact_name || ''
      fill :contact_name, @user_questionnaire.questions.find_by(question_text: 'Organization Contact Name') || @contact_name || ''

      fill :public_benefits_no, 'No'
      fill :public_benefits_yes, 'Off'

      fill :tax_exempt_no, case @user_questionnaire.questions.find_by(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                             when nil then
                               'Off'
                             when 'Yes' then
                               'Off'
                             else
                               'No'
                           end

      fill :tax_exempt_yes, case @user_questionnaire.questions.find_by(question_text: 'Are you exempt from taxation pursuant to 26 U.S.C 501 ( c )(3)?').response.response_text.to_s.downcase
                              when nil then
                                'Off'
                              when 'No' then
                                'Off'
                              else
                                'Yes'
                            end

      fill :school_district_name, case @user_questionnaire.questions.find_by(question_text: 'School District Name').response.response_text
                                    when nil then
                                      'N/A'
                                    else
                                      @user_questionnaire.questions.find_by(question_text: 'School District Name').response.response_text
                                  end

      fill :school_district_no, case @user_questionnaire.questions.find_by(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                  when nil then
                                    'Off'
                                  when 'Yes' then
                                    'Off'
                                  else
                                    'No'
                                end

      fill :school_district_yes, case @user_questionnaire.questions.find_by(question_text: 'Are you a School District?').response.response_text.to_s.downcase
                                   when nil then
                                     'Off'
                                   when 'No' then
                                     'Off'
                                   else
                                     'Yes'
                                 end

      fill :special_district_name, case @user_questionnaire.questions.find_by(question_text: 'Special District Name').response.response_text
                                     when nil then
                                       'N/A'
                                     else
                                       @user_questionnaire.questions.find_by(question_text: 'Special District Name').response.response_text
                                   end

      fill :special_district_no, case @user_questionnaire.questions.find_by(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                   when nil then
                                     'Off'
                                   when 'Yes' then
                                     'Off'
                                   else
                                     'No'
                                 end

      fill :special_district_yes, case @user_questionnaire.questions.find_by(question_text: 'Are you a Special District?').response.response_text.to_s.downcase
                                    when nil then
                                      'Off'
                                    when 'No' then
                                      'Off'
                                    else
                                      'Yes'
                                  end

    elsif @user.account_type.downcase == 'individual'

      fill :name, @contact_name

      [:contact_name, :school_district_name, :special_district_name].each do |field|
        fill field, not_applicable
      end

      [:tax_exempt_no, :school_district_no, :special_district_no].each do |field|
        fill field, 'No'
      end

      [:tax_exempt_yes, :school_district_yes, :special_district_yes].each do |field|
        fill field, 'Off'
      end

      if @user_questionnaire.questions.find_by(question_text: 'Are you receiving CalFresh benefits?').response.response_text.to_s.downcase == 'yes' or
          @user_questionnaire.questions.find_by(question_text: 'Are you receiving CalWORKS benefits?').response.response_text.to_s.downcase == 'yes' or
          @user_questionnaire.questions.find_by(question_text: 'Are you receiving County Relief benefits?').response.response_text.to_s.downcase == 'yes' or
          @user_questionnaire.questions.find_by(question_text: 'Are you receiving General Relief benefits?').response.response_text.to_s.downcase == 'yes' or
          @user_questionnaire.questions.find_by(question_text: 'Are you receiving General Assistance benefits?').response.response_text.to_s.downcase == 'yes' or
          @user_questionnaire.questions.find_by(question_text: 'Are you receiving MediCal benefits?').response.response_text.to_s.downcase == 'yes'
        public_benefits_yes = 'Yes'
        public_benefits_no = 'Off'
      else
        public_benefits_yes = 'Off'
        public_benefits_no = 'No'
      end

      fill :public_benefits_no, public_benefits_no
      fill :public_benefits_yes, public_benefits_yes
    end

    fill :applicant_name, @contact_name

    [:sign_date, :application_date].each do |field|
      fill field, Date.today.to_s
    end

    fill :city, @address[:city].to_s

    [:phone, :fax].each do |field|
      fill field, @contact.send(field)
    end

    state_zip_code = @address[:state].to_s + ' ' + @address[:zip_code].to_s
    fill :state_zip, state_zip_code

    true
  end
end
