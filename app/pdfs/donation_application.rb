class DonationApplication
  def initialize(user, address, user_q, listing)
    fill :date, Date.today.to_s

    @name = user.entity_name.to_s.empty ? user.name : user.entity_name
    @contact_name = user.name
    @applicant_name = user.name
    @application_date = :date
    @sign_date = :date
    @address = address.street_address_1 + (address.street_address_2.empty ? '' : address.street_address_2)
    @city = address.city
    @state_zip = address.state + ' ' + address.zip_code
    @phone = address.phone
    @fax = address.fax
    @title = user_q.question.find(question_text: 'Title').response.response_text
    @tax_exempt_yes = user_q.question.find(question_text: 'Tax Exempt').response.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off'
    @tax_exempt_no = user_q.question.find(question_text: 'Tax Exempt').response.response_text.to_s.downcase == 'yes' ? 'Off' : 'No'
    @school_district_name = user_q.question.find(question_text: 'School District').response.response_text
    @school_district_yes = user_q.question.find(question_text: 'School District').response.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off'
    @school_district_no = user_q.question.find(question_text: 'School District').response.response_text.to_s.downcase == 'yes' ? 'Off' : 'No'
    @special_district_name = user_q.question.find(question_text: 'Special District').response.response_text
    @special_district_yes = user_q.question.find(question_text: 'Special District').response.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off'
    @special_district_no = user_q.question.find(question_text: 'Special District').response.response_text.to_s.downcase == 'yes' ? 'Off' : 'No'
    @public_benefits_yes = user_q.question.find(question_text: 'Public Benefits').response.response_text.to_s.downcase == 'yes' ? 'Yes' : 'Off'
    @public_benefits_no = user_q.question.find(question_text: 'Public Benefits').response.response_text.to_s.downcase == 'yes' ? 'Off' : 'No'
    @donation_request = listing.description
  end
end