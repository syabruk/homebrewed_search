require 'spec_helper'

RSpec.describe Search::CharFilter::Phonetic do
  describe '#perform' do
    subject { described_class.execute_perform(string, {}) }

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    context 'with string' do
      let(:string) { 'phone quard ёшка' }
      specify do
        expect(subject).to match_tokens({'fone kard ешка': 'phone quard ёшка'})
      end
    end

    context 'with array' do
      let(:string) { %w(phone quard ёшка) }
      specify do
        expect(subject).to match_tokens({fone: :phone, kard: :quard, 'ешка': 'ёшка'})
      end
    end
  end
end
