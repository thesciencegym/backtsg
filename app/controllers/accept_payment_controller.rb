class AcceptPaymentController < ApplicationController
  def transaction_callback
    success = params['obj']['success']
    if success
      @order = Order.find_by(accept_order_id: params['obj']['order']['id'])
      @order.status = 'succeeded'
      @order.save!
      @product = Product.find(order.product_id)
      @user = User.find(order.user_id)
      # check 3la member_id if exists
      # if yes put subs directly
      # if not  put user and put subs
    end
    render json: { "transaction status": success }, status: :ok
  end
end
