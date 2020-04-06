class OrderService
  def self.create(user_id, product, status)
    Order.create!(user_id: user_id, price: product.price, status: status, product_id: product.id)
  end
end
