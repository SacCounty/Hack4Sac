class DonationApplicationPdf < FillablePdfForm

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes)
    @user_questionnaire = attributes[:user_questionnaire]
    @listing = attributes[:listing]
    super
  end

  protected

  def fill_out
    fill :date, Date.today.to_s

    # TODO: may have to change question texts after the database is seeded...
    questions = {
      tax_exempt: @user_questionnaire.questions.where(question_text: 'Tax Exempt').first,
      school_district: @user_questionnaire.questions.where(question_text: 'School District Specify').first,
      special_district: @user_questionnaire.questions.where(question_text: 'Special District Specify').first,
      public_benefits: @user_questionnaire.questions.where(question_text: 'Public Benefits').first
    }

    fields = [
      # Get fields from Sac County Surplus Donation Application
      :name                  => @user_questionnaire.entity_name || @user_questionnaire.name || '',
      :applicationDate       => :date,
      :address               => @user_questionnaire.address.street_address_1 + (@user_questionnaire.address.street_address_2.to_s.empty ? '' : ', ' + @user_questionnaire.address.street_address_2),
      :contactName           => @user_questionnaire.entity_name || '',
      :city                  => @user_questionnaire.address.city,
      :stateZip              => @user_questionnaire.address.state + ' ' + @user_questionnaire.address.zip,
      :phone                 => @user_questionnaire.address.phone,
      :fax                   => @user_questionnaire.address.fax,
      :taxExemptYes          => questions[:tax_exempt].responses.response_text.to_s.downcase == 'yes',
      :taxExemptNo           => questions[:tax_exempt].responses.response_text.to_s.downcase != 'yes',
      :schoolDistrictName    => questions[:school_district].responses.response_text.to_s,
      :schoolDistrictYes     => questions[:school_district].responses.response_text.to_s.downcase == 'yes',
      :schoolDistrictNo      => questions[:school_district].responses.response_text.to_s.downcase != 'yes',
      :specialDistrictName   => questions[:special_district].responses.response_text.to_s,
      :specialDistrictYes    => questions[:special_district].responses.response_text.to_s.downcase == 'yes',
      :specialDistrictNo     => questions[:special_district].responses.response_text.to_s.downcase != 'yes',
      :publicBenefitsYes     => questions[:public_benefits].responses.response_text.to_s.downcase == 'yes',
      :publicBenefitsNo      => questions[:public_benefits].responses.response_text.to_s.downcase != 'yes',
      :donationRequest       => @listing.description,
      :applicantName         => @user_questionnaire.user.name,
      :signDate              => :date,
      :title                 => @user_questionnaire.questions.where(question_text: 'Title').responses.response_text.to_s,
    ]

    fields.each do |field_name, record_contents|
      fill field_name, @user_questionnaire.send(record_contents)
    end

    true
  end

  private :def_attributes

  def persisted?
    false
  end
end
