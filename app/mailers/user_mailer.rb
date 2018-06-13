class UserMailer < ApplicationMailer
  default from: 'phoebe.azucena@outlook.com'

  def contact_form(email, name, message)
    @message = message
    mail(from: email, to: 'phoebe.azucena@outlook.com', subject: "Contact form message from #{name}")
  end

  def welcome(user)
    @appname = "Salt of the Sea"
    mail(to: user.email, subject: "Welcome to #{@appname}!")
  end
end
