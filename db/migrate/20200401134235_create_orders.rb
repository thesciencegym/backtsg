class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :tsg_product_id
      t.integer :accept_order_id
      t.float :price
      t.timestamps
    end
  end
end
