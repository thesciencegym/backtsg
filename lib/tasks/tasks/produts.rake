# frozen_string_literal: true

namespace :products do
  task add_products: :environment do
    product = Product.create!(code: '1', name: 'Online Membership-1', price: 150000, duration: 4,
                              credits: { "Fitness assessment": '1',
                                        "Physiotherapy screening": '1',
                                        "Nutrition session": '2' })
    p "#{product.name} is added"

    product = Product.create!(code: '2', name: 'Online Membership-3', price: 330000, duration: 12,
                              credits: { "Fitness assessment": '2',
                                        "Physiotherapy screening": '1',
                                        "Nutrition session": '6' })
    p "#{product.name} is added"

    product = Product.create!(code: '3', name: 'Online Classes ', price: 80000, duration: 1)
    p "#{product.name} is added"

    product = Product.create!(code: '4', name: 'Pro Athlete Nutrition Package', price: 70000, duration: 6,
                              credits: { "Nutrition sessions": '3' })
    p "#{product.name} is added"

    product = Product.create!(code: '5', name: 'Immunity Enhancing Nutrition Package', price: 60000, duration: 4,
                              credits: { "Nutrition sessions": '4'})
    p "#{product.name} is added"
  end
end
