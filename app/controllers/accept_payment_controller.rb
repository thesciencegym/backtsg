class AcceptPaymentController < ApplicationController
  before_action :set_txn_codes

  def transaction_callback
    request.post? ? transaction_proceed : transaction_response
  end

  def transaction_proceed
    success = params['obj']['success']
    if success
      order = Order.find_by(accept_order_id: params['obj']['order']['id'])
      order.status = 'succeeded'
      order.save!
    end
    render json: { "transaction status": success }, status: :ok
  end

  def transaction_response
    result = @txn[params['txn_response_code']]
    render json: { "result": result, "txn_response_code": params['txn_response_code']}, status: :ok
  end

  private

  def set_txn_codes
    @txn = {
      '0' => 'success',
      '1' => 'There was an error processing the transaction',
      '2' => 'Contact card issuing bank',
      '4' => 'Expired Card',
      '5' => 'Insufficient Funds',
      '6' => 'Payment is already being processed'
    }
  end
end
