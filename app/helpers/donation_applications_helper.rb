module DonationApplicationsHelper
  def export_pdf
    pdf_form = DonationApplicationPdf.new(user: current_user, listing: @listing).export
    send_file(pdf_form, type: 'application/pdf')
  end

  def display_pdf
    pdf_form = DonationApplicationPdf.new(user: current_user, listing: @listing).export
    send_file(pdf_form, disposition: 'inline', type: 'application/pdf')
  end
end
