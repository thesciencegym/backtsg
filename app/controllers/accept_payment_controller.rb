class AcceptPaymentController < ApplicationController
  def notification_callback
    p '**************'
    p "in notification_callback params is #{params}"
    p '***************'
    render json: "ok", status: :ok
  end

  def transaction_callback
    p '**************'
    p "in transaction_callback params is #{params}"
    p '***************'
    render json: "ok", status: :ok
  end
end