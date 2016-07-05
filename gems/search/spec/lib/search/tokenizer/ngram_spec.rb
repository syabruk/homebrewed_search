RSpec.describe Search::Tokenizer::Ngram do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty string' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    [
      [%w(tablets cars), {abl: :tablets, ars: :cars, ble: :tablets, car: :cars, ets: :tablets, let: :tablets, tab: :tablets}],
      ['tables', {tab: :tables, abl: :tables, ble: :tables, les: :tables}],
      ['table,tablets', {',ta': 'table,tablets', abl: 'table,tablets', ble: 'table,tablets', 'e,t': 'table,tablets', ets: 'table,tablets', 'le,': 'table,tablets', let: 'table,tablets', tab: 'table,tablets'}],
      ['table, tablets', {abl: 'table, tablets', ble: 'table, tablets', ets: 'table, tablets', 'le,': 'table, tablets', let: 'table, tablets', tab: 'table, tablets'}]
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
