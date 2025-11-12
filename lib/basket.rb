require_relative 'product'
require_relative 'delivery_rule'

class Basket
  def initialize(products, delivery_rules, offers = [])
    @product_catalog = products
    @delivery_rule = delivery_rules
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @product_catalog.find { |p| p.code == product_code }
    puts "Unknown product code: #{product_code}" unless product
    @items << product
  end

  def total
    subtotal = calculate_subtotal
    discount = calculate_total_discount
    delivery = @delivery_rule.calculate(subtotal - discount)
    total_price = subtotal - discount + delivery

    puts "🛒 Basket Summary"
    puts "-----------------------------"
    grouped_items.each do |product, count|
      puts "#{product.name} (#{product.code}) x#{count} - $#{format('%.2f', product.price * count)}"
    end
    puts "-----------------------------"
    puts "Subtotal:        $#{format('%.2f', subtotal)}"
    puts "Discount:        -$#{format('%.2f', discount)}"
    puts "Delivery Charge:  $#{format('%.2f', delivery)}"
    puts "Total:           $#{format('%.2f', total_price)}"
    puts "============================="
  end

  private

  def calculate_subtotal
    @items.sum(&:price)
  end

  def calculate_total_discount
    grouped_items.sum do |product, count|
      calculate_offer_discount(product.code, count, product.price)
    end
  end

  def calculate_offer_discount(code, count, price)
    offer = @offers.find { |o| o.code == code }
    return 0 unless offer

    case offer.type
    when :bogo
      eligible_pairs = count / 2
      eligible_pairs * (price * offer.details[:discount])
    else
      0
    end
  end

  def grouped_items
    @items.tally
  end
end
