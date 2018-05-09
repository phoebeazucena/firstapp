class UserMailer < ApplicationMailer
  default from: 'paz@wintermoongames.com'

  def contact_form(email, name, message)
  @message = message
    mail(from: email, to: 'paz@wintermoongames.com', subject: "Contact form message from #{name}")
  end
end
