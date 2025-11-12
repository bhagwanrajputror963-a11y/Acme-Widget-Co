require_relative 'lib/product'
require_relative 'lib/basket'
require_relative 'lib/delivery_rule'
require_relative 'lib/offer'

class Main
  def initialize(product_codes)
    # Initialize products using Product class
    @products = [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
    # Initialize offers using Offer class
    @offers = [
      Offer.new(code: 'R01', type: :bogo, details: { buy: 1, get: 1, discount: 0.5 }),
      Offer.new(code: 'G01', type: :bogo, details: { buy: 1, get: 1, discount: 0.5 })
    ]
    # Initialize delivery rules using DeliveryRule class
    @delivery_rules = DeliveryRule.new([
      { threshold: 50, cost: 4.95 },
      { threshold: 90, cost: 2.95 },
      { threshold: Float::INFINITY, cost: 0.00 }
    ])

    @product_codes = product_codes
  end

  def show_total
    # Create a new basket with products, delivery rules, and offers
    basket = Basket.new(@products, @delivery_rules, @offers)

    # Add each product to the basket
    @product_codes.each { |code| basket.add(code) }

    # Display final total of the basket
    basket.total
  end
end
