class OrderService
  def self.create(tsg_product_id, price, status)
    Order.create!(tsg_product_id: tsg_product_id, price: price, status: status)
  end
end
