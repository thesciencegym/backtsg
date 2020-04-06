class Order < ApplicationRecord
  enum status: %i[pending succeeded]

  belongs_to :user
  has_one :product, class_name: 'product', foreign_key: 'product_id'
end
