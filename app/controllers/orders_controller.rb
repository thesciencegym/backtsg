class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    render json: @order.as_json(include: :product)
  end
end
