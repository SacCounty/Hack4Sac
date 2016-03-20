class DonationApplicationPdf < FillablePdfForm

  def initialize(user_q, listing)
    @user_q = user_q
    @listing = listing
    super()
  end

  protected

  def fill_out
    fill :date, Date.today.to_s

    # TODO: may have to change question texts after the database is seeded...
    questions = [
      "tax_exempt" => @user_q.question.find(question_text: 'Tax Exempt'),
      "school_district" => @user_q.question.find(question_text: 'School District Specify'),
      "special_district" => @user_q.question.find(question_text: 'Special District Specify'),
      "public_benefits" => @user_q.question.find(question_text: 'Public Benefits'),
    ]

    fields = [
      # Get fields from Sac County Surplus Donation Application
      "name"                => @user_q.entity_name.to_s.empty ? @user_q.name : @user_q.entity_name,
      "applicationDate"     => :date,
      "address"             => @user_q.address.street_address_1 + (@user_q.address.street_address_2.to_s.empty ? '' : @user_q.address.street_address_2),
      "contactName"         => @user_q.entity_name.to_s.empty ? '' : @user_q.entity_name,
      "city"                => @user_q.address.city,
      "stateZip"            => @user_q.address.state + ' ' + @user_q.address.zip,
      "phone"               => @user_q.address.phone,
      "fax"                 => @user_q.address.fax,
      "taxExemptYes"        => questions['tax_exempt'].responses.response_text.to_s.downcase == 'yes' ? true : false,
      "taxExemptNo"         => questions['tax_exempt'].responses.response_text.to_s.downcase == 'yes' ? false : true,
      "schoolDistrictName"  => questions['school_district'].responses.response_text.to_s,
      "schoolDistrictYes"   => questions['school_district'].responses.response_text.to_s.downcase == 'yes' ? true : false,
      "schoolDistrictNo"    => questions['school_district'].responses.response_text.to_s.downcase == 'yes' ? false : true,
      "specialDistrictName" => questions['special_district'].responses.response_text.to_s,
      "specialDistrictYes"  => questions['special_district'].responses.response_text.to_s.downcase == 'yes' ? true : false,
      "specialDistrictNo"   => questions['special_district'].responses.response_text.to_s.downcase == 'yes' ? false : true,
      "publicBenefitsYes"   => questions['public_benefits'].responses.response_text.to_s.downcase == 'yes' ? true : false,
      "publicBenefitsNo"    => questions['public_benefits'].responses.response_text.to_s.downcase == 'yes' ? false : true,
      "donationRequest"     => @listing.description,
      "applicantName"       => @user_q.name,
      "signDate"            => :date,
      "title"               => @user_q.question.find(question_text: 'Title').responses.response_text.to_s,
    ]

    fields.each do |field_name, record_contents|
      fill field_name, @user_q.send(record_contents)
    end

    true
  end

end
