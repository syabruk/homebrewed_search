RSpec.describe Search::Tokenizer::Standard do
  describe '#perform' do
    subject { described_class.execute_perform(string, {}) }

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    [
      [%w[tables cars], { tables: :tables, cars: :cars }],
      ['tables', { tables: :tables }],
      ['table,tablets', { table: :table, tablets: :tablets }],
      ['table tablets', { table: :table, tablets: :tablets }]
    ].each do |input_string, output_tokens|
      context "passed #{input_string}" do
        let(:string) { input_string }
        specify do
          expect(subject).to match_tokens(output_tokens)
        end
      end
    end
  end
end
