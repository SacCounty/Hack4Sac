class DonationApplicationPdf < FillablePdfForm

  def initialize(user_q)
    @user_q = user_q
    super()
  end

  protected

  def fill_out
    fill :date, Date.today.to_s
    fields = [
      # Get fields from Sac County Surplus Donation Application
    ]

    fields.each do |field|
      fill field, @user_q.send(field)
    end

    true
  end

end
