class AcceptPaymentController < ApplicationController
  before_action :set_txn_codes

  def transaction_callback
    success = params['obj']['success']
    if success
      order = Order.find_by(accept_order_id: params['obj']['order']['id'])
      order.status = 'succeeded'
      order.save!
    end
    render json: { "transaction status": success }, status: :ok
  end
end
