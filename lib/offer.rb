class Offer
  attr_reader :code, :type, :details

  def initialize(code:, type:, details:)
    @code = code
    @type = type
    @details = details # details example: { buy: 1, get: 1, discount: 0.5 }
  end
end