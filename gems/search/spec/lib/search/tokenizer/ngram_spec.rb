require 'spec_helper'

RSpec.describe Search::Tokenizer::Ngram do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty string' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    [
      [%w(tablets cars), %w(abl ars ble car ets let tab)],
      ['tables', %w(tab abl ble les)],
      ['table,tablets', %w(,ta abl abl ble ble e,t ets le, let tab tab)],
      ['table, tablets', %w(abl abl ble ble ets le, let tab tab)]
    ].each do |input_value, output_tokens|
      context "passed #{input_value}" do
        let(:value) { input_value }
        specify do
          expect(subject).to match_tokens(output_tokens)
        end
      end
    end
  end
end
