class AddProductToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product, null: false, foreign_key: true
    remove_column :orders, :tsg_product_id
  end
end
