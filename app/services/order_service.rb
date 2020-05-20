class OrderService
  def self.create(user_id, product, status, special_price = nil, payment_meyhod)
    order = Order.new(user_id: user_id, status: status, product_id: product.id,
                      payment_method: payment_method)
    order.price = special_price ? product.special_price : product.price
    order.save!
    order
  end
end
