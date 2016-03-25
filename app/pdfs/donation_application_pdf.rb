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

    fill :contact_name, @user.name
    fill :applicant_name, @user.name

    [:sign_date, :application_date].each do |field|
      fill field, Date.today.to_s
    end

    [:city, :phone, :fax].each do |field|
      fill field, @address.send(field)
    end

    state_zip_code = 'CA 95616'#@address.state.to_s + ' ' + @address.zip_code.to_s
    fill :state_zip, state_zip_code

    fill :tax_exempt_no, case @user_q.question.find(question_text: 'Tax Exempt').response.response_text.to_s.downcase
                           when nil then
                             'Off'
                           else
                             'No'
                         end

    fill :tax_exempt_yes, case @user_q.question.find(question_text: 'Tax Exempt').response.response_text.to_s.downcase
                            when nil then
                              'Off'
                            else
                              'Yes'
                          end

    fill :school_district_name, case @user_q.question.find(question_text: 'School District (Specify)').response.response_text
                                  when nil then
                                    ''
                                  else
                                    @user_q.question.find(question_text: 'School District (Specify)').response.response_text
                                end

    fill :school_district_no, case @user_q.question.find(question_text: 'School District').response.response_text.to_s.downcase
                                when nil then
                                  'Off'
                                else
                                  'No'
                              end

    fill :school_district_yes, case @user_q.question.find(question_text: 'School District').response.response_text.to_s.downcase
                                 when nil then
                                   'Off'
                                 else
                                   'Yes'
                               end

    fill :special_district_name, case @user_q.question.find(question_text: 'Special District (Specify)').response.response_text
                                   when nil then
                                     ''
                                   else
                                     @user_q.question.find(question_text: 'Special District (Specify)').response.response_text
                                 end

    fill :special_district_no, case @user_q.question.find(question_text: 'Special District').response.response_text.to_s.downcase
                                 when nil then
                                   'Off'
                                 else
                                   'No'
                               end

    fill :special_district_yes, case @user_q.question.find(question_text: 'Special District').response.response_text.to_s.downcase
                                  when nil then
                                    'Off'
                                  else
                                    'Yes'
                                end

    fill :public_benefits_no, case @user_q.question.find(question_text: 'Public Benefits').response.response_text.to_s.downcase
                                when nil then
                                  'Off'
                                else
                                  'No'
                              end

    fill :public_benefits_yes, case @user_q.question.find(question_text: 'Public Benefits').response.response_text.to_s.downcase
                                 when nil then
                                   'Off'
                                 else
                                   'Yes'
                               end

    true
  end

end
