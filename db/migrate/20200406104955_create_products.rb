class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :discription
      t.string :name
      t.float :price
      t.string :service_type
      t.integer :duration
      t.float :credit_amount
      t.string :code, unique: true
      t.timestamps
    end
  end
end
