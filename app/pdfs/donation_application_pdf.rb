class DonationApplicationPdf < FillablePdfForm


  def initialize(args = {})
    @user_questionnaire = args[:user_questionnaire]
    @user = @user_questionnaire.user
    @user_contact = @user.addresses.first
    @listing = args[:listing]
    super()
  end

  protected

  def fill_out
    fill :date, Date.today.to_s

    # Get fields from Sac County Surplus Donation Application
    fields = [
      :name                  => @user.entity_name || @user.name || '',
      :applicationDate       => :date,
      :address               => @user_contact.street_address_1 + (@user_contact.street_address_2 ? ", #{@user_contact.street_address_2}" : '',
      :contactName           => @user.entity_name || @user.name || '',
      :city                  => @user_contact.city,
      :stateZip              => @user_contact.state + ' ' + @user_contact.zip,
      :phone                 => @user_contact.phone,
      :fax                   => @user_contact.fax,

      # Update queries to questionnaire
      # e.g. @user_questionnaire.question.where(question_text: "").response.response_text
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
      :donationRequest       => "(##{@listing.id}) " + @listing.description,
      :applicantName         => @user.name,
      :signDate              => :date,
      :title                 => @user_questionnaire.questions.where(question_text: 'Title').responses.response_text.to_s,
    ]

    fields.each do |field_name, record_contents|
      fill field_name, @user_questionnaire.send(record_contents)
    end

    true
  end
end
