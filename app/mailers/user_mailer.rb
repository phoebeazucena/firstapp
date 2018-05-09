class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def contact_form(email, name, message)
  @message = message
    mail(from: email, to: 'paz@wintermoongames.com', subject: "Contact form message from #{}")
  end
end
