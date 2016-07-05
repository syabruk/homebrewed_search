require 'spec_helper'

RSpec.describe Search::TokenFilter::Stopword do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty value' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    context 'with string' do
      let(:value) { 'or' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    context 'with array' do
      let(:value) { %w(TaBlE or and carpet) }
      specify do
        expect(subject).to match_tokens(%w(TaBlE carpet))
      end
    end
  end
end
