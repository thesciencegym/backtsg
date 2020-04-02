class Order < ApplicationRecord
  enum status: %i[pending succeeded]
end
