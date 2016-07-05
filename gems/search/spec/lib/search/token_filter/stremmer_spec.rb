require 'spec_helper'

RSpec.describe Search::TokenFilter::Stremmer do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty value' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    context 'with string' do
      let(:value) { 'body' }
      specify do
        expect(subject).to match_tokens(%w(bodi))
      end
    end

    context 'with array' do
      let(:value) { %w(table tablets body) }
      specify do
        expect(subject).to match_tokens(%w(tabl tablet bodi))
      end
    end
  end
end
