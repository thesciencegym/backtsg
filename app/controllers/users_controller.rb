class UsersController < ApplicationController
  include AcceptPayment

  def order
    @product = Product.find_by(code: order_params[:product_code])
    @user = User.find_by(email: order_params[:email])
    unless @user
      @user = create_user
    end
    authentication = user_auth
    order_record = OrderService.create(@user.id, @product, 'pending')
    order = order_regestration(authentication['token'], authentication['profile']['id'],
                               @product, order_record.id)
    order_record.accept_order_id = order['id']
    order_record.save!
    p_token = payment_token(authentication['token'], order_record, @user)
    order_record.payment_token = p_token['token']
    order_record.save!
    url = 'https://accept.paymobsolutions.com/api/acceptance/iframes/25190?payment_token=' + p_token['token']
    redirect_to url
    # render json: p_token, status: :ok
  end

  def update_users
    User.get_VG_users
    render json: "done", status: :ok
  end

  private

  def order_params
    params.permit(:email, :first_name, :last_name, :phone_number, :gender, :product_code)
  end

  def create_user
    User.create!(email: order_params[:email], first_name: order_params[:first_name],
                 last_name: order_params[:last_name], mobile: order_params[:phone_number],
                 gender: order_params[:gender])
  end
end
