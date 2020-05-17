module AcceptPayment
  def user_auth
    url = 'https://accept.paymobsolutions.com/api/auth/tokens'
    body = { "api_key": ENV['ACCEPT_API_KEY'] }
    Request.post(url, body)
  end

  def order_regestration(token, merchant_id, product, order_id, special_price, shipping_data, user)
    url = 'https://accept.paymobsolutions.com/api/ecommerce/orders'
    price = special_price ? product.special_price : product.price
    body = {
      "auth_token": token, # auth token obtained from step1
      "delivery_needed": product.require_shipping,
      "merchant_id": merchant_id, # merchant_id obtained from step 1
      "amount_cents": price,
      "currency": 'EGP',
      "merchant_order_id": order_id,
      "items": [
        {
          name: product.name,
          amount_cents: price
        }
      ]
    }
    if product.require_shipping
      body["shipping_data"] = delivery_payload(shipping_data, user)
    end
    Request.post(url, body)
  end

  def payment_token(token, order, user, integration_id, billing_data)
    url = 'https://accept.paymobsolutions.com/api/acceptance/payment_keys'
    body = {
      "auth_token": token, # auth token obtained from step1
      "amount_cents": order.price,
      "expiration": 3600,
      "order_id": order.accept_order_id, # id obtained in step 2
      "billing_data": {
        "first_name": user.first_name,
        "last_name": user.last_name,
        "phone_number": user.mobile,
        "email": user.email,
        "street": billing_data['street'],
        "building": billing_data['building'],
        "apartment": billing_data['apartment'],
        "floor": billing_data['floor'],
        "postal_code": billing_data['postal_code'],
        "city": billing_data['city'],
        "state": billing_data['state'],
        "country": 'EG'
      },
      "currency": 'EGP',
      "integration_id": integration_id, # card integration_id will be provided upon signing up
      "lock_order_when_paid": false
    }
    Request.post(url, body)
  end

  def cash_pay_request(p_token)
    url = 'https://accept.paymobsolutions.com/api/acceptance/payments/pay'
    body = {
      "source": {
        "identifier": "cash",
        "subtype": "CASH",
      },
      "payment_token": p_token
    }
    Request.post(url, body)
  end

  private

  def delivery_payload(shipping_data, user)
    {
      "apartment": shipping_data['apartment'],
      "email": user.email,
      "floor": shipping_data['floor'],
      "first_name": user.first_name,
      "street": shipping_data['street'],
      "building": shipping_data['building'],
      "phone_number": user.mobile,
      "postal_code": shipping_data['postal_code'],
      "city": shipping_data['city'],
      "country": 'EG',
      "last_name": user.last_name,
      "state": shipping_data['state']
    }
  end
end
