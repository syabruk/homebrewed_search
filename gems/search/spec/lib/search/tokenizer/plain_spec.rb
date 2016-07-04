require 'spec_helper'

RSpec.describe Search::Tokenizer::Plain do
  describe '#perform' do
    subject { described_class.execute_perform(string) }

    context 'empty arguments' do
      subject { described_class.execute_perform }
      specify do
        expect(subject).to eq([])
      end
    end

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens([])
      end
    end

    context 'some string' do
      let(:string) { 'table' }
      specify do
        expect(subject).to match_tokens(%w(table))
      end
    end
  end
end
