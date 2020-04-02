class AddPaymentTokenToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_token, :string
  end
end
