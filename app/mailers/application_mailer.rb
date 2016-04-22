class ApplicationMailer < ActionMailer::Base
  default from: ENV['HARETECH_USERNAME']
  layout 'mailer'
end
