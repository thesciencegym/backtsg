class Product < ApplicationRecord
  validates :code, uniqueness: true
end
