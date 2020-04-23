# frozen_string_literal: true

# product's price is in cents
# product's duration in weeks
namespace :products do
  task add_products: :environment do
    # product = Product.create!(code: '1', name: 'Online Membership-1', price: 150000, duration: 4,
    #                           credits: { "fitness-assesment": '1',
    #                                     "physiotherapy-session-1": '1',
    #                                     "nutrition-session-4": '2' })
    # p "#{product.name} is added"

    # product = Product.create!(code: '2', name: 'Online Membership-3', price: 330000, duration: 12,
    #                           credits: { "fitness-assesment": '2',
    #                                     "physiotherapy-session-1": '1',
    #                                     "nutrition-session-4": '6' })
    # p "#{product.name} is added"

    # product = Product.create!(code: '3', name: 'Online Classes ', price: 80000, duration: 1)
    # p "#{product.name} is added"

    # product = Product.create!(code: '4', name: 'Pro Athlete Nutrition Package', price: 70000, duration: 6,
    #                           credits: { "nutrition-session-4": '3' })
    # p "#{product.name} is added"

    # product = Product.create!(code: '5', name: 'Immunity Enhancing Nutrition Package', price: 60000, duration: 4,
    #                           credits: { "nutrition-session-4": '4'})
    # p "#{product.name} is added"

    # product = Product.create!(code: '6', name: 'One Class', price: 15000)
    # p "#{product.name} is added"

    product = Product.create!(code: '7', name: 'March To Your Goal', price: 220000, duration: 4,
                              credits: { "nutrition-session-4": '4' }, special_price: 120000)
    p "#{product.name} is added"
  end
end
