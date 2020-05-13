class UsersController < ApplicationController
  include AcceptPayment

  def order
    @product = Product.find_by(code: order_params[:product_code])
    @user = User.find_by(email: order_params[:email])
    puts "country",  order_params[:country]
    unless @user
      User.get_VG_users
      @user = User.find_by(email: order_params[:email])
      @user.nil? ? @user = create_user : @user
    end
    @user.update(first_name: order_params[:first_name],last_name: order_params[:last_name], mobile: order_params[:phone_number], gender: order_params[:gender], city: order_params[:city], country: order_params[:country])
    
    authentication = user_auth
    special_price = true if @product.special_price && @user.member_id && @user.member?
    puts "special_price", special_price
    order_record = OrderService.create(@user.id, @product, 'pending', special_price)
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               @product, order_record.id, special_price)
    puts "order", order
    render "order not created", status: :ok and return if order.nil? || order['id'].nil?
    order_record.accept_order_id = order['id']
    order_record.save!
    p_token = payment_token(authentication['token'], order_record, @user)
    puts "p_token", p_token

    order_record.payment_token = p_token['token']
    order_record.save!
    amount = (order_record.price/100).to_i
    url = "https://accept.paymobsolutions.com/api/acceptance/iframes/#{ENV['ACCEPT_IFRAME_ID']}?payment_token=" + p_token['token'] + "&amount=" + amount.to_s
    redirect_to url
    # render json: p_token, status: :ok
  end

  private

  def order_params
    params.permit(:email, :first_name, :last_name, :phone_number, :gender,
                  :product_code, :city, :country)
  end

  def create_user
    User.create!(email: order_params[:email], first_name: order_params[:first_name],
                 last_name: order_params[:last_name], mobile: order_params[:phone_number],
                 gender: order_params[:gender], city: order_params[:city], country: order_params[:country],
                 timestamp_edit: (Time.now.to_f.round(3)*1000).to_i)
  end
end
