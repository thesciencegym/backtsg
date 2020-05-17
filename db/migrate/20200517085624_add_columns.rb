class AddColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_status, :integer
    add_column :products, :require_shipping, :boolean, defult: false
  end
end
