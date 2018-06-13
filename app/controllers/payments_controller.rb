class PaymentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    token = params[:stripeToken] #Create the charge on Stripe's servers. This will charge users's card
    begin
      charge = Stripe::Charge.create(
        amount: @product.price*100,
        currency: "usd",
        source: token,
        description: params[:stripeEmail]
      )

    if charge.paid
      Order.create(product_id: @product.id, user_id: @user.id, total: @product.price),
      receipt_email: 'user.email'
    end

    rescue Stripe::CardError => e # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "We're sorry but there was an error processing your payment: #{err[:message]}"
    end
  end
end
