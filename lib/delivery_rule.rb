class DeliveryRule
  # Default delivery rules
  DELIVERY_RULES = [
    { threshold: 50, cost: 4.95 },
    { threshold: 90, cost: 2.95 },
    { threshold: Float::INFINITY, cost: 0.00 }
  ].freeze

  def initialize(rules = DELIVERY_RULES)
    @rules = rules.sort_by { |r| r[:threshold] }
  end

  # Calculate the delivery cost based on subtotal
  def calculate(total)
    rule = @rules.find { |r| total < r[:threshold] }
    rule ? rule[:cost] : 0.0
  end
end