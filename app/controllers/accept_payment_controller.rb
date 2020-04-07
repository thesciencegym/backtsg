require 'securerandom'
class AcceptPaymentController < ApplicationController
  def transaction_callback
    if check_hmac
      success = params['obj']['success']
      if success
        order_id = params['obj']['order']['id']
        return if order_id.nil?

        @order = Order.find_by(accept_order_id: order_id)
        @order.status = 'succeeded'
        @order.save!
        @product = Product.find(@order.product_id)
        @user = @order.user

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
    else
      render json: "unmatched HMAC", status: :ok
    end
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

  def check_hmac
    hmac = params['hmac']
    data = params['obj']
    string_conc = data['amount_cents'].to_s + data['created_at'] + data ['currency'] + 
                  data['error_occured'].to_s + data['has_parent_transaction'].to_s + data['id'].to_s +
                  data['integration_id'].to_s + data['is_3d_secure'].to_s + data['is_auth'].to_s +
                  data['is_capture'].to_s + data['is_refunded'].to_s + data['is_standalone_payment'].to_s +
                  data['is_voided'].to_s + data['order']['id'].to_s + data['owner'].to_s + data['pending'].to_s +
                  data['source_data']['pan'].to_s + data['source_data']['sub_type'] +
                  data['source_data']['type'] + data['success'].to_s
    calc_hmac = OpenSSL::HMAC.hexdigest('SHA512', ENV['ACCEPT_HMAC_SECRET'], string_conc)
    hmac == calc_hmac
  end
end
