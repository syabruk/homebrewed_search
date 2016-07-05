RSpec.describe Post do
  describe 'applies search callbacks' do
    describe 'adds to index' do
      let(:record) { Post.create(title: 'cars') }

      subject { record }

      specify do
        expect { subject }.to index(record)
      end
    end

    describe 'removes from index' do
      let(:record) { Post.create(title: 'cars') }

      subject { record.destroy }

      specify do
        expect { subject }.to delete_from_index(record)
      end
    end
  end
end
