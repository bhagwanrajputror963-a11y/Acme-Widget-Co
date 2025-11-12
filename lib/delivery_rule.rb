class DeliveryRule
  def initialize(rules = [])
    @rules = rules.sort_by { |r| r[:threshold] }
  end

  # Calculate the delivery cost based on subtotal
  def calculate(total)
    rule = @rules.find { |r| total < r[:threshold] }
    rule ? rule[:cost] : 0.0
  end
end