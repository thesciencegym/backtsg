class UsersController < ApplicationController
  include AcceptPayment

  def bing
    # 6 is tsg_produt_id
    # 600 is price
    authentication = user_auth
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               params['price'], params['tsg_product_id'])
    order_record = OrderService.create(order['id'], params['tsg_product_id'], params['price'], 'pending')
    p_token = payment_token(authentication['token'], order_record)
    order_record.payment_token = p_token['token']
    order_record.save!
    render json: p_token, status: :ok
  end

  def transaction_callback
    p 'yes got here'
  end
end
