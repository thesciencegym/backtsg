require 'securerandom'
class AcceptPaymentController < ApplicationController
  def transaction_callback
    success = params['obj']['success']
    if success
      @order = Order.find_by(accept_order_id: params['obj']['order']['id'])
      @order.status = 'succeeded'
      @order.save!
      @product = Product.find(@order.product_id)
      @user = User.find(@order.user_id)

      unless @user.member_id
        create_vg_user
      end

      if @product.credits
        @product.credits.each do |key, value|
          response = add_user_credits(key, value)
          p "credit request sent and result is #{response}"
        end
      end
    end

    render json: { "transaction status": success }, status: :ok
  end

  private

  def create_vg_user
    url = 'https://api.virtuagym.com/api/v1/club/25396/member'
    body = {
       "firstname": @user.first_name,
       "lastname": @user.last_name,
       "email": @user.email,
       "gender": @user.gender,
       "active": true,
       "place": @user.city,
       "mobile": @user.mobile
      }
    response = Request.put(url, body)
    if response['result']
      p "user is created in VG #{response['result']}"
      @user.member_id = response['result']['member_id']
      @user.timestamp_edit = response['result']['timestamp_edit']
      @user.save!
    end
  end

  def add_user_credits(service_type, credit_amount)
    url = 'https://api.virtuagym.com/api/v1/club/25396/credit'
    body = {
      "member_id": @user.member_id,
      "credit_amount": credit_amount.to_i,
      "service_type": service_type,
      "client_id": SecureRandom.uuid
    }
    Request.put(url, body)
  end
end
