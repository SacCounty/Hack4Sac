class DonationApplicationPdf < FillablePdfForm

  def initialize(donation_application)
    @donation_application = donation_application
    super()
  end

  protected

  def fill_out
    fields = [
      :name,
      :contact_name,
      :applicant_name,
      :application_date,
      :sign_date,
      :address,
      :city,
      :state_zip,
      :phone,
      :fax,
      :title,
      :tax_exempt_yes,
      :tax_exempt_no,
      :school_district_name,
      :school_district_yes,
      :school_district_no,
      :special_district_name,
      :special_district_yes,
      :special_district_no,
      :public_benefits_yes,
      :public_benefits_no,
      :donation_request,
    ]

    fields.each do |field|
      fill field, @donation_application.send(field)
    end

    true
  end

end
