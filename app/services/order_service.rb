class OrderService
  def self.create(accept_order_id, tsg_product_id, price, status)
    Order.create!(accept_order_id: accept_order_id, tsg_product_id: tsg_product_id,
                  price: price, status: status)
  end
end
