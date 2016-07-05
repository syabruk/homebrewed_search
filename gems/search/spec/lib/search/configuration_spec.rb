RSpec.describe Search::Configuration do
  let(:object) { described_class.__send__(:new) }

  it 'default state' do
    expect(object.config).to eq({})
  end

  describe '#enable_indexing!' do
    subject { object.enable_indexing! }

    specify do
      expect { subject }
        .to change { object.config[:enabled] }
        .to(true)
    end
  end

  describe '#disable_indexing!' do
    subject { object.disable_indexing! }

    specify do
      expect { subject }
        .to change { object.config[:enabled] }
        .to(false)
    end
  end
end
