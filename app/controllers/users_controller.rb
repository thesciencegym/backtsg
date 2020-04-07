class UsersController < ApplicationController
  include AcceptPayment

  def order
    @product = Product.find_by(code: order_params[:product_code])
    @user = User.find_by(email: order_params[:email])
    unless @user
      User.get_VG_users
      @user = User.find_by(email: order_params[:email])
      @user.nil? ? @user = create_user : @user
    end
    @user.update(first_name: order_params[:first_name],last_name: order_params[:last_name], mobile: order_params[:phone_number])
    
    authentication = user_auth
    order_record = OrderService.create(@user.id, @product, 'pending')
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               @product, order_record.id)
    puts "order", order
    order_record.accept_order_id = order['id']
    order_record.save!
    p_token = payment_token(authentication['token'], order_record, @user)
    puts "p_token", p_token

    order_record.payment_token = p_token['token']
    order_record.save!
    url = 'https://accept.paymobsolutions.com/api/acceptance/iframes/25190?payment_token=' + p_token['token']
    redirect_to url
    # render json: p_token, status: :ok
  end

  private

  def order_params
    params.permit(:email, :first_name, :last_name, :phone_number, :gender,
                  :product_code, :city)
  end

  def create_user
    User.create!(email: order_params[:email], first_name: order_params[:first_name],
                 last_name: order_params[:last_name], mobile: order_params[:phone_number],
                 gender: order_params[:gender], city: order_params[:city],
                 timestamp_edit: order_params[:timestamp_edit])
  end
end
