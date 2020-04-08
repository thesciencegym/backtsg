class Order < ApplicationRecord
  enum status: %i[pending succeeded]

  belongs_to :user
  belongs_to :product
end
