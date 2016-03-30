class ListingMailer < ApplicationMailer

  # donor and donee are the corresponding Users
  def confirm_follow_listing(donor, donee, listing)
    @donor = donor
    @donee = donee
    @listing = listing

    @subject = 'Your Interest in Listing #' + @listing.id + ' has been sent!'

    mail(to: @donee.email, subject: @subject)
  end

  # donor and donee are the corresponding Users
  def follow_listing(donor, donee, listing)
    @donor = donor
    @donee = donee
    @listing = listing

    @subject = 'HareTech (' + @donee.address.city + '): Interest in Listing #' + @listing.id

    mail(to: @donor.email, subject: @subject)
  end

end
