require 'spec_helper'

RSpec.describe Search::Tokenizer::Standard do
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

    [
      ['tables', %w(tables)],
      ['table,tablets', %w(table tablets)],
      ['table tablets', %w(table tablets)]
    ].each do |input_string, output_tokens|
      context input_string do
        let(:string) { input_string }
        specify do
          expect(subject).to match_tokens(output_tokens)
        end
      end
    end
  end
end
