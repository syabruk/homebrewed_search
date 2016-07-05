RSpec.describe Search do
  class PostsSearch < Search::Index
    model Post
    text_field :title
  end

  describe '.index!' do
    subject { described_class.index!(record) }

    let(:record) { Search.without_indexing { Post.create(title: 'cars') } }

    specify do
      expect { subject }.to index(record)
    end
  end

  describe '.delete!' do
    subject { described_class.delete!(record) }

    let(:record) { Post.create(title: 'cars') }

    specify do
      expect { subject }.to delete_from_index(record)
    end
  end

  describe '.without_indexing' do
    subject do
      Search.without_indexing { Post.create(title: 'cars') }
    end

    specify do
      expect { PostsSearch.index! }.not_to index
    end
  end
end
