# frozen_string_literal: true

require_relative 'lib/product'
require_relative 'lib/basket'
require_relative 'lib/delivery_rule'
require_relative 'lib/offer'

# Main application file to run the shopping basket
class Main
  def initialize(product_codes)
    # Initialize products using Product class
    @products = initialize_products
    # Initialize offers using Offer class
    @offers = initialize_offers
    # Initialize delivery rules using DeliveryRule class
    @delivery_rules = initialize_delivery_rules
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

  private

  def initialize_products
    [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
  end

  def initialize_offers
    [
      Offer.new(code: 'R01', type: :buy_one_get_one_half, discount: 0.5),
      Offer.new(code: 'G01', type: :buy_one_get_one_half, discount: 0.5)
    ]
  end

  def initialize_delivery_rules
    DeliveryRule.new([
                       { threshold: 50, cost: 4.95 },
                       { threshold: 90, cost: 2.95 },
                       { threshold: Float::INFINITY, cost: 0.00 }
                     ])
  end
end
