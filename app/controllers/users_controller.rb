class UsersController < ApplicationController
  include AcceptPayment

  def order
    unless params[:payment_method] == 'card' || params[:payment_method] == 'cash'
      render json: { "message": 'payment availible only in cash or card please input the right method' }, status: :unprocessable_entity && return
    end

    @product = Product.find_by(code: order_params[:product_code])
    @user = User.find_by(email: order_params[:email])
    unless @user
      User.get_VG_users
      @user = User.find_by(email: order_params[:email])
      @user.nil? ? @user = create_user : @user
    end
    @user.update(first_name: order_params[:first_name],last_name: order_params[:last_name],
                 mobile: order_params[:phone_number], gender: order_params[:gender],
                 city: order_params[:city], country: order_params[:country])

    special_price = true if @product.special_price && @user.member_id && @user.member?

    @order_record = OrderService.create(@user.id, @product, 'pending', special_price, params[:payment_method])
    ### payment
    authentication = user_auth
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               @product, @order_record, special_price, params[:billing_data], @user)

    render json: order, status: :ok and return if order.nil? || order['id'].nil?
    @order_record.accept_order_id = order['id']
    @order_record.save!

    integration_id = params[:payment_method] == 'card' ? ENV['ACCEPT_INTEGRATION__CARD_ID'] : ENV['ACCEPT_INTEGRATION__CASH_ID']
    @p_token = payment_token(authentication['token'], @order_record, @user,
                             integration_id, params[:billing_data])
    ### payment

    @order_record.payment_token = @p_token['token']
    @order_record.save!

    if params[:payment_method] == 'card'
      card_payment
    elsif params[:payment_method] == 'cash'
      cash_payment
    end
  end

  def cash_payment
    pay_cash_res = cash_pay_request(@p_token['token'])
    if pay_cash_res['pending'] == 'true'
      @order_record.delivery_status = 'Scheduled'
      @order_record.save!
      render json: {"success": true}, status: :ok
    else
      render json: {"success": false}, status: :unprocessable_entity
    end
  end

  def card_payment
    amount = (@order_record.price/100).to_i
    url = "https://accept.paymobsolutions.com/api/acceptance/iframes/#{ENV['ACCEPT_IFRAME_ID']}?payment_token=" + @p_token['token'] + "&amount=" + amount.to_s
    redirect_to url
  end

  private

  def order_params
    params.permit(:email, :first_name, :last_name, :phone_number, :gender,
                  :product_code, :city, :country, :payment_method)
  end

  def billing_params
    params.require(:billing_data).permit(:apartment, :floor, :street, :building,
                                         :postal_code, :state, :city)
  end

  def create_user
    User.create!(email: order_params[:email], first_name: order_params[:first_name],
                 last_name: order_params[:last_name], mobile: order_params[:phone_number],
                 gender: order_params[:gender], city: order_params[:city], country: order_params[:country],
                 timestamp_edit: (Time.now.to_f.round(3)*1000).to_i)
  end
end
