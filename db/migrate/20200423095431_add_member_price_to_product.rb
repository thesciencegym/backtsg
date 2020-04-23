class AddMemberPriceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :special_price, :float
  end
end
