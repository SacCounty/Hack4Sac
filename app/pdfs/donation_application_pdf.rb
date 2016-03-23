class DonationApplicationPdf < FillablePdfForm

  def initialize(user, user_q, listing)
    @user = user
    @user_q = user_q
    @listing = listing
    super()
  end

  protected

  def fill_out
    fill :date, Date.today.to_s

    # TODO: may have to change question texts after the database is seeded...
    #questions = [
    #  'tax_exempt'        => @user_q.question.find(question_text: 'Tax Exempt'),
    #  'school_district'   => @user_q.question.find(question_text: 'School District Specify'),
    #  'special_district'  => @user_q.question.find(question_text: 'Special District Specify'),
    #  'public_benefits'   => @user_q.question.find(question_text: 'Public Benefits'),
    #]

    # TODO: split fields by model...might have to create a new model that's just a donation request and contains the
    # TODO: (cont) fields for everything...otherwise we might get some weird side effects...currently not loading data
    # TODO: (cont) but it IS outputting the PDF
    # segment fields by origin
    #user_fields = [
    #  applicationDate:      :date,
    #  signDate:             :date,
    #  name:                 @user.entity_name.to_s.empty ? @user.name : @user.entity_name,
    #  address:              @user.address.street_address_1 + (@user.address.street_address_2.to_s.empty ? '' : @user.address.street_address_2),
    #  contactName:          @user.entity_name.to_s.empty ? @user.name : @user.entity_name,
    #  city:                 @user.address.city,
    #  stateZip:             @user.address.state + ' ' + @user.address.zip_code,
    #  phone:                @user.address.phone,
    #  fax:                  @user.address.fax,
    #]

    user_fields = [
        :name,
        :entity_name,
    ]

    user_q_fields = [
      # Get fields from Sac County Surplus Donation Application
      taxExemptYes: 'Yes',
      taxExemptNo: 'Off',
      schoolDistrictName: 'schoolDistrictName',
      schoolDistrictYes: 'Off',
      schoolDistrictNo: 'No',
      specialDistrictName: 'specialDistrictName',
      specialDistrictYes: 'Off',
      specialDistrictNo: 'No',
      publicBenefitsYes: 'Off',
      publicBenefitsNo: 'No',
      donationRequest: 'donationRequest',
      applicantName: 'applicantName',
      title: 'title',
      #name:                   @user_q.entity_name.to_s.empty ? @user_q.name : @user_q.entity_name,
      #applicationDate:        :date,
      #address:                @user_q.address.street_address_1 + (@user_q.address.street_address_2.to_s.empty ? '' : @user_q.address.street_address_2),
      #contactName:            @user_q.entity_name.to_s.empty ? '' : @user_q.entity_name,
      #city:                   @user_q.address.city,
      #stateZip:               @user_q.address.state + ' ' + @user_q.address.zip,
      #phone:                  @user_q.address.phone,
      #fax:                    @user_q.address.fax,
      #taxExemptYes:           questions['tax_exempt'].responses.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off',
      #taxExemptNo:            questions['tax_exempt'].responses.response_text.to_s.downcase == 'yes' ? 'Off' : 'No',
      #schoolDistrictName:     questions['school_district'].responses.response_text.to_s,
      #schoolDistrictYes:      questions['school_district'].responses.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off',
      #schoolDistrictNo:       questions['school_district'].responses.response_text.to_s.downcase == 'yes' ? 'Off' : 'No',
      #specialDistrictName:    questions['special_district'].responses.response_text.to_s,
      #specialDistrictYes:     questions['special_district'].responses.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off',
      #specialDistrictNo:      questions['special_district'].responses.response_text.to_s.downcase == 'yes' ? 'Off' : 'No',
      #publicBenefitsYes:      questions['public_benefits'].responses.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off',
      #publicBenefitsNo:       questions['public_benefits'].responses.response_text.to_s.downcase == 'yes' ? 'Off' : 'No',
      #donationRequest:        @listing.description,
      #applicantName:          @user_q.name,
      #signDate:               :date,
      #title:                  @user_q.question.find(question_text: 'Title').responses.response_text.to_s,
    ]

    user_fields.each do |user_field|
      fill user_field, @user.send(user_field)
    end

    #user_q_fields.each do |user_q_field|
    #    fill user_q_field, @user_q.send(user_q_field)
    #end

    true
  end

end
