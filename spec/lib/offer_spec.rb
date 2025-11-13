# frozen_string_literal: true

# spec/offer_spec.rb
require_relative '../../lib/offer'

RSpec.describe Offer do # rubocop:disable Metrics/BlockLength
  describe '#discount_for' do # rubocop:disable Metrics/BlockLength
    let(:bogo_offer) { described_class.new(code: 'R01', type: :buy_one_get_one_half, discount: 0.5) }

    context 'when count is zero' do
      it 'returns 0 discount' do
        expect(bogo_offer.discount_for(0, 32.95)).to eq(0)
      end
    end

    context 'when count is 1' do
      it 'returns 0 discount (no pair eligible)' do
        expect(bogo_offer.discount_for(1, 32.95)).to eq(0)
      end
    end

    context 'when count is 2' do
      it 'applies discount on one item' do
        # buy_one_get_one_half → second item 50% off
        expected_discount = 32.95 * 0.5
        expect(bogo_offer.discount_for(2, 32.95)).to eq(expected_discount)
      end
    end

    context 'when count is 3' do
      it 'applies discount only on eligible pair' do
        # Only one pair eligible, third item full price
        expected_discount = 32.95 * 0.5
        expect(bogo_offer.discount_for(3, 32.95)).to eq(expected_discount)
      end
    end

    context 'when count is 4' do
      it 'applies discount on two pairs' do
        # Two pairs eligible, 50% off on each second item
        expected_discount = 32.95 * 0.5 * 2
        expect(bogo_offer.discount_for(4, 32.95)).to eq(expected_discount)
      end
    end

    context 'when offer type is unknown' do
      let(:unknown_offer) { described_class.new(code: 'R01', type: :unknown, discount: 0.5) }

      it 'returns 0 discount' do
        expect(unknown_offer.discount_for(2, 32.95)).to eq(0)
      end
    end
  end
end
