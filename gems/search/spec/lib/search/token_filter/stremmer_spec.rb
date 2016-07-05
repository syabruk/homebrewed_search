RSpec.describe Search::TokenFilter::Stremmer do
  describe '#perform' do
    subject { described_class.execute_perform(value, {}) }

    context 'empty value' do
      let(:value) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    context 'with string' do
      let(:value) { 'body' }
      specify do
        expect(subject).to match_tokens({bodi: :body})
      end
    end

    context 'with array' do
      let(:value) { %w(table tablets body) }
      specify do
        expect(subject).to match_tokens({tabl: :table, tablet: :tablets, bodi: :body})
      end
    end
  end
end
