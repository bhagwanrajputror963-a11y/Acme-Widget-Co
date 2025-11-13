# frozen_string_literal: true

require_relative 'product'
require_relative 'delivery_rule'

# Basket class to manage products, offers, and delivery rules
class Basket
  attr_reader :items, :product_catalog, :delivery_rule, :offers

  def initialize(products, delivery_rules, offers = [])
    @product_catalog = products
    @delivery_rule = delivery_rules
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = product_catalog.find { |p| p.code == product_code }
    return puts "Unknown product code: #{product_code}" unless product

    items << product
  end

  def total
    return 0 if items.empty?

    subtotal = calculate_subtotal
    discount = calculate_total_discount
    delivery = delivery_rule.calculate(subtotal - discount)
    (subtotal - discount + delivery).round(2)
  end

  private

  def calculate_subtotal
    items.sum(&:price)
  end

  def calculate_total_discount
    grouped_items.sum do |product, count|
      offer = offers.find { |o| o.code == product.code }
      offer ? offer.discount_for(count, product.price) : 0
    end
  end

  def grouped_items
    items.tally
  end
end
