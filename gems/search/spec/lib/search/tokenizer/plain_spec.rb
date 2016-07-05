RSpec.describe Search::Tokenizer::Plain do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty string' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    context 'with array' do
      let(:value) { %w[table car] }
      specify do
        expect(subject).to match_tokens(table: :table, car: :car)
      end
    end

    context 'with string' do
      let(:value) { 'table car' }
      specify do
        expect(subject).to match_tokens('table car': 'table car')
      end
    end
  end
end
