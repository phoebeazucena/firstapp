class PaymentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    token = params[:stripeToken] #Create the charge on Stripe's servers. This will charge users's card

    begin
      charge = Stripe::Charge.create(
        amount: (@product.price*100).to_i, #converts price to integer
        currency: "usd",
        source: token,
        description: params[:stripeEmail],
        receipt_email: @user.email
      )

    if charge.paid
      Order.create(product_id: @product.id, user_id: @user.id, total: @product.price.to_i)
      UserMailer.confirm_payment(@user, @product).deliver_now
      flash[:notice] = "Thank you for your purchase!"
      redirect_to product_path(@product)
    end

    rescue Stripe::CardError => e # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "We're sorry but there was an error processing your payment: #{err[:message]}"
    end
  end
end
