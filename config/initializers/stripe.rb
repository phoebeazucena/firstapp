if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_BB3LxVk4HGXdG031iLy4sf1k',
    secret_key: 'sk_test_Sziu8FC8fPZwsII6LU164Jul'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
