class SimplePagesController < ApplicationController
  def index
  end
  def landing_page
    @featured_product = Product.limit(3)
  end
  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now
    ActionMailer::Base.mail(from: @email, to: 'paz@wintermoongames.com', subject: "Contact form message from #{@name}", body: @message).deliver_now
  end
end
