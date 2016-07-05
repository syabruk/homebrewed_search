require 'spec_helper'

RSpec.describe Search::CharFilter::StripHtml do
  describe '#perform' do
    subject { described_class.execute_perform(string, {}) }

    context 'empty string' do
      let(:string) { '' }
      specify do
        expect(subject).to match_tokens({})
      end
    end

    context 'with string' do
      let(:string) { "<a href='google.com'>Google</a>" }
      specify do
        expect(subject).to match_tokens({Google: "<a href='google.com'>Google</a>"})
      end
    end

    context 'with array' do
      let(:string) { ["<div>Car</div>", "<p>Sun</p>"] }
      specify do
        expect(subject).to match_tokens({Car: "<div>Car</div>", Sun: "<p>Sun</p>"})
      end
    end
  end
end
