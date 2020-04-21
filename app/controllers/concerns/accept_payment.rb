module AcceptPayment
  def user_auth
    url = 'https://accept.paymobsolutions.com/api/auth/tokens'
    body = { "api_key": ENV['ACCEPT_API_KEY'] }
    Request.post(url, body)
  end

  def order_regestration(token, merchant_id, product, order_id)
    url = 'https://accept.paymobsolutions.com/api/ecommerce/orders'
    body = {
      "auth_token": token, # auth token obtained from step1
      "delivery_needed": false,
      "merchant_id": merchant_id, # merchant_id obtained from step 1
      "amount_cents": product.price,
      "currency": 'EGP',
      "merchant_order_id": order_id,
      "items": [
        {
          name: product.name,
          amount_cents: product.price
        }
      ]
    }
    Request.post(url, body)
  end

  def payment_token(token, order, user)
    url = 'https://accept.paymobsolutions.com/api/acceptance/payment_keys'
    body = {
      "auth_token": token, # auth token obtained from step1
      "amount_cents": order.price,
      "expiration": 3600,
      "order_id": order.accept_order_id, # id obtained in step 2
      "billing_data": {
        "apartment": 'NA',
        "email": user.email,
        "floor": 'NA',
        "first_name": user.first_name,
        "street": 'NA',
        "building": 'NA',
        "phone_number": user.mobile,
        "postal_code": 'NA', 
        "city": user.city,
        "country": 'Egypt',
        "state": 'NA',
        "last_name": user.last_name
      },
      "currency": 'EGP',
      "integration_id": ENV['ACCEPT_INTEGRATION_ID'], # card integration_id will be provided upon signing up
      "lock_order_when_paid": false
    }
    Request.post(url, body)
  end
end
