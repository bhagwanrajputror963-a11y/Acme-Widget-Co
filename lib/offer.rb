# frozen_string_literal: true

# Offer class to represent different types of offers
class Offer
  attr_reader :code, :type, :discount

  def initialize(code:, type:, discount:)
    @code = code
    @type = type
    @discount = discount
  end

  # Calculate discount for a product based on count and price
  def discount_for(count, price)
    return 0 unless count.positive?

    case type
    when :buy_one_get_one_half
      eligible_pairs = count / 2
      eligible_pairs * (price * discount)
    else
      0
    end
  end
end
