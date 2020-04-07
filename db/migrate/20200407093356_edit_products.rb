class EditProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :service_type
    remove_column :products, :credit_amount
    add_column :products, :credits, :json
  end
end
