class OrderService
  def self.create(user_id, product, status, special_price = nil)
    order = Order.new(user_id: user_id, status: status, product_id: product.id)
    order.price = special_price ? product.special_price : product.price
    order.save!
    order
  end
end
