# frozen_string_literal: true

# product's price is in cents
# product's duration in weeks
namespace :products do
  task add_products: :environment do
    product = Product.create!(code: '1', name: 'Online Membership-1', price: 150000, duration: 4,
                              credits: { "fitness-assesment": '1',
                                        "physiotherapy-session-1": '1',
                                        "nutrition-session-4": '2' })
    p "#{product.name} is added"

    product = Product.create!(code: '2', name: 'Online Membership-3', price: 330000, duration: 12,
                              credits: { "fitness-assesment": '2',
                                        "physiotherapy-session-1": '1',
                                        "nutrition-session-4": '6' })
    p "#{product.name} is added"

    product = Product.create!(code: '3', name: 'Online Classes-1-week', price: 60000, duration: 1)
    p "#{product.name} is added"

    product = Product.create!(code: '4', name: 'Pro Athlete Nutrition Package', price: 70000, duration: 6,
                              credits: { "nutrition-session-4": '3' })
    p "#{product.name} is added"

    product = Product.create!(code: '5', name: 'General Nutrition Program', price: 60000, duration: 4,
                              credits: { "nutrition-session-4": '4'})
    p "#{product.name} is added"

    product = Product.create!(code: '6', name: 'One Class', price: 10000)
    p "#{product.name} is added"

    product = Product.create!(code: '7', name: 'March To Your Goal', price: 240000, duration: 4,
                              credits: { "nutrition-session-4": '4' }, special_price: 120000)
    p "#{product.name} is added"

    # new products added 3 may 2020
    product = Product.create!(code: '8', name: 'Online Superheroes program-12', price: 240000)
    p "#{product.name} is added"

    product = Product.create!(code: '9', name: 'Online Superheroes program-24', price: 375000)
    p "#{product.name} is added"

    product = Product.create!(code: '10', name: 'Online Superheroes program-48', price: 620000)
    p "#{product.name} is added"

    product = Product.create!(code: '11', name: 'Online Rehabilitation program-1', price: 150000, duration: 4)
    p "#{product.name} is added"

    product = Product.create!(code: '12', name: 'Online Rehabilitation program-3', price: 350000, duration: 12)
    p "#{product.name} is added"

  end

  # new products added 31 may 2020
  task add_products_2: :environment do
    Product.all.each do |pro|
      pro.require_shipping = false
      pro.save
    end

    product = Product.create!(code: '13', name: 'MyZone Training Belt', price: 250000, require_shipping: true)
    p "#{product.name} is added"

    product = Product.create!(code: '14', name: 'Online Classes-2-week', price: 100000, duration: 2, require_shipping: false)
    p "#{product.name} is added"

    product = Product.create!(code: '15', name: 'Online Classes-1-month', price: 150000, duration: 4, require_shipping: false)
    p "#{product.name} is added"
  end

    # new products added 1 June 2020
    task add_products_2: :environment do
  
      #individual
      product = Product.create!(code: '16', name: 'Tsg2go individual 8 sessions', price: 240000, require_shipping: false, 
      credits: { "nutrition-session-4": '2', "tsg2go-session": '8' })
      p "#{product.name} is added"

      product = Product.create!(code: '17', name: 'Tsg2go individual 12 sessions', price: 330000, require_shipping: false, 
      credits: { "nutrition-session-4": '4', "tsg2go-session": '12' })
      p "#{product.name} is added"

      product = Product.create!(code: '18', name: 'Tsg2go individual 16 sessions', price: 400000, require_shipping: false, 
      credits: { "nutrition-session-4": '6', "tsg2go-session": '16' })
      p "#{product.name} is added"

      product = Product.create!(code: '19', name: 'Tsg2go individual 24 sessions', price: 540000, require_shipping: false, 
      credits: { "nutrition-session-4": '8', "tsg2go-session": '24' })
      p "#{product.name} is added"

      product = Product.create!(code: '20', name: 'Tsg2go individual 48 sessions', price: 960000, require_shipping: false, 
      credits: { "nutrition-session-4": '16', "tsg2go-session": '48' })
      p "#{product.name} is added"

      # couple
      product = Product.create!(code: '21', name: 'Tsg2go couple 8 sessions', price: 440000, require_shipping: false, 
      credits: { "nutrition-session-4": '2', "tsg2go-session": '8' })
      p "#{product.name} is added"

      product = Product.create!(code: '22', name: 'Tsg2go couple 12 sessions', price: 600000, require_shipping: false, 
      credits: { "nutrition-session-4": '4', "tsg2go-session": '12' })
      p "#{product.name} is added"

      product = Product.create!(code: '23', name: 'Tsg2go couple 16 sessions', price: 720000, require_shipping: false, 
      credits: { "nutrition-session-4": '6', "tsg2go-session": '16' })
      p "#{product.name} is added"

      product = Product.create!(code: '24', name: 'Tsg2go couple 24 sessions', price: 980000, require_shipping: false, 
      credits: { "nutrition-session-4": '8', "tsg2go-session": '24' })
      p "#{product.name} is added"

      product = Product.create!(code: '25', name: 'Tsg2go couple 48 sessions', price: 1730000, require_shipping: false, 
      credits: { "nutrition-session-4": '16', "tsg2go-session": '48' })
      p "#{product.name} is added"


      #family
      product = Product.create!(code: '26', name: 'Tsg2go family 8 sessions', price: 800000, require_shipping: false, 
      credits: { "nutrition-session-4": '2', "tsg2go-session": '8' })
      p "#{product.name} is added"

      product = Product.create!(code: '27', name: 'Tsg2go family 12 sessions', price: 1080000, require_shipping: false, 
      credits: { "nutrition-session-4": '4', "tsg2go-session": '12' })
      p "#{product.name} is added"

      product = Product.create!(code: '28', name: 'Tsg2go family 16 sessions', price: 1300000, require_shipping: false, 
      credits: { "nutrition-session-4": '6', "tsg2go-session": '16' })
      p "#{product.name} is added"

      product = Product.create!(code: '29', name: 'Tsg2go family 24 sessions', price: 1750000, require_shipping: false, 
      credits: { "nutrition-session-4": '8', "tsg2go-session": '24' })
      p "#{product.name} is added"

      product = Product.create!(code: '30', name: 'Tsg2go family 48 sessions', price: 3000000, require_shipping: false, 
      credits: { "nutrition-session-4": '16', "tsg2go-session": '48' })
      p "#{product.name} is added"
 
    end
end
