require 'spec_helper'

RSpec.describe Search::TokenFilter::Lowercase do
  describe '#perform' do
    subject { described_class.execute_perform(string, {}) }

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    context 'with string' do
      let(:string) { 'TaBlE' }
      specify do
        expect(subject).to match_tokens({table: 'TaBlE'})
      end
    end

    context 'with array' do
      let(:string) { %w(TaBlE CAR) }
      specify do
        expect(subject).to match_tokens({table: 'TaBlE', car: 'CAR'})
      end
    end
  end
end
