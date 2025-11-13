# frozen_string_literal: true

require 'rspec'
require_relative '../main'
require_relative '../lib/product'
require_relative '../lib/basket'
require_relative '../lib/delivery_rule'
require_relative '../lib/offer'

RSpec.describe Main do
  describe '#show_total' do
    it 'calculates the correct total for multiple products with offers applied' do
      main_app = Main.new(%w[R01 R01 R01 G01 G01])

      # Calculate expected total
      subtotal = 32.95 * 3 + 24.95 * 2
      discount = (32.95 * 0.5) + (24.95 * 0.5) # BOGO-half offers applied once per pair
      adjusted_subtotal = subtotal - discount
      delivery = 0.0 # total >= 90 → free delivery
      expected_total = (adjusted_subtotal + delivery).round(2)

      expect(main_app.show_total).to eq(expected_total)
    end

    it 'calculates total with delivery charge for small basket without offers' do
      main_app = Main.new(['B01'])

      subtotal = 7.95
      discount = 0.0
      adjusted_subtotal = subtotal - discount
      delivery = 4.95 # subtotal < 50
      expected_total = (adjusted_subtotal + delivery).round(2)

      expect(main_app.show_total).to eq(expected_total)
    end
  end
end
