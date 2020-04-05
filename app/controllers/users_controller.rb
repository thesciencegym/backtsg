class UsersController < ApplicationController
  include AcceptPayment

  def order
    authentication = user_auth
    order_record = OrderService.create(params['tsg_product_id'], params['price'], 'pending')
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               params['price'], order_record.id)
    order_record.accept_order_id = order['id']
    order_record.save!
    p_token = payment_token(authentication['token'], order_record)
    order_record.payment_token = p_token['token']
    order_record.save!
    url = 'https://accept.paymobsolutions.com/api/acceptance/iframes/25190?payment_token=' + p_token['token']
    redirect_to url
    # render json: p_token, status: :ok
  end
end
