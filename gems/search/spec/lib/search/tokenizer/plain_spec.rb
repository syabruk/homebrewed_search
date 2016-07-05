require 'spec_helper'

RSpec.describe Search::Tokenizer::Plain do
  describe '#perform' do
    subject { described_class.execute_perform(string, {}) }

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    context 'with array' do
      let(:string) { %w(table car) }
      specify do
        expect(subject).to match_tokens(%w(table car))
      end
    end

    context 'with string' do
      let(:string) { 'table' }
      specify do
        expect(subject).to match_tokens(%w(table))
      end
    end
  end
end
