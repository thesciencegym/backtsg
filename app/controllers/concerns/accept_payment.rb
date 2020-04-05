module AcceptPayment
  def user_auth
    url = 'https://accept.paymobsolutions.com/api/auth/tokens'
    body = { "api_key": ENV['API_KEY'] }
    Request.post(url, body)
  end

  def order_regestration(token, merchant_id, price, tsg_product_id)
    url = 'https://accept.paymobsolutions.com/api/ecommerce/orders'
    body = {
      "auth_token": token, # auth token obtained from step1
      "delivery_needed": false,
      "merchant_id": merchant_id, # merchant_id obtained from step 1
      "amount_cents": price,
      "currency": 'EGP',
      "merchant_order_id": tsg_product_id
    }
    Request.post(url, body)
  end

  def payment_token(token, order)
    url = 'https://accept.paymobsolutions.com/api/acceptance/payment_keys'
    body = {
      "auth_token": token, # auth token obtained from step1
      "amount_cents": order.price,
      "expiration": 3600,
      "order_id": order.accept_order_id, # id obtained in step 2
      "billing_data": {
        "apartment": '803',
        "email": 'claudette09@exa.com',
        "floor": '42',
        "first_name": 'Clifford',
        "street": 'Ethan Land',
        "building": '8028',
        "phone_number": '+86(8)9135210487',
        "city": 'Jaskolskiburgh',
        "country": 'EG',
        "last_name": 'Nicolas'
      },
      "currency": 'EGP',
      "integration_id": 15483, # card integration_id will be provided upon signing up
      "lock_order_when_paid": false
    }
    Request.post(url, body)
  end
end
