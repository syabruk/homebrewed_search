require 'spec_helper'

RSpec.describe Search::TokenFilter::Length do
  describe '#perform' do
    subject { described_class.execute_perform(value, params) }
    let(:params) { {} }

    context 'with array' do
      let(:value) { %w(a on the maps) }

      context 'with default params' do
        specify do
          expect(subject).to match_tokens({a: :a, on: :on, the: :the, maps: :maps})
        end
      end

      context 'specified min' do
        let(:params) { { min: 2 } }

        specify do
          expect(subject).to match_tokens({on: :on, the: :the, maps: :maps})
        end
      end

      context 'specified max' do
        let(:params) { { max: 3 } }

        specify do
          expect(subject).to match_tokens({a: :a, on: :on, the: :the})
        end
      end

      context 'specified min and max' do
        let(:params) { { min: 2, max: 3 } }

        specify do
          expect(subject).to match_tokens({on: :on, the: :the})
        end
      end
    end
  end
end
