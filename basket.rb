class Basket
  PRODUCTS = {
    'R01' => { name: 'Red Widget', price: 32.95 },
    'G01' => { name: 'Green Widget', price: 24.95 },
    'B01' => { name: 'Blue Widget', price: 7.95 }
  }.freeze

  DELIVERY_RULES = [
    { threshold: 50, cost: 4.95 },
    { threshold: 90, cost: 2.95 },
    { threshold: Float::INFINITY, cost: 0.00 }
  ].freeze

  # Offers format:
  # [
  #   { code: 'R01', type: :bogo, details: { buy: 1, get: 1, discount: 0.5 } },
  # ]
  def initialize(delivery_rules = DELIVERY_RULES, offers = [])
    @items = []
    @delivery_rules = delivery_rules
    @offers = offers
  end

  def add(product_code)
    return @items << product_code if PRODUCTS.key?(product_code)

    puts "Unknown product code: '#{product_code}'"
  end

  def total
    subtotal = calculate_subtotal
    discount = calculate_total_discount
    delivery = calculate_delivery(subtotal - discount)
    (subtotal - discount + delivery).round(2)
  end

  def summary
    subtotal = calculate_subtotal
    discount = calculate_total_discount
    delivery = calculate_delivery(subtotal - discount)
    total_price = subtotal - discount + delivery

    puts "🛒 Basket Summary"
    puts "-----------------------------"
    grouped_items.each do |code, count|
      product = PRODUCTS[code]
      puts "#{product[:name]} (#{code}) x#{count} - $#{format('%.2f', product[:price] * count)}"
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
    @items.sum { |code| PRODUCTS[code][:price] }
  end

  def calculate_total_discount
    grouped_items.sum do |code, count|
      price = PRODUCTS[code][:price]
      calculate_offer_discount(code, count, price)
    end
  end

  def calculate_offer_discount(code, count, price)
    offer = @offers.find { |o| o[:code] == code }
    return 0 unless offer

    case offer[:type]
    when :bogo
      eligible_pairs = count / 2
      eligible_pairs * (price * offer[:details][:discount])
    else
      0
    end
  end

  def calculate_delivery(adjusted_subtotal)
    @delivery_rules.find { |rule| adjusted_subtotal < rule[:threshold] }[:cost]
  end

  def grouped_items
    @items.tally
  end
end
