class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: 'from@example.com'
  layout 'mailer'

  def send_signup_email
    mail( :to => 'mohammad.edeeb@gmail.com',
    :subject => 'Thanks for signing up for our amazing app' )
  end

end
