RSpec.describe Search::Repository do
  let(:object) { described_class.send(:new) }

  it 'default state' do
    expect(object.searches).to eq({})
  end

  describe '#register_search' do
    class PostsSearch < Search::Index
      model Post
      text_field :title
    end

    before { object.register_search(Post, PostsSearch) }

    specify do
      expect(object.searches[Post]).to eq([PostsSearch])
    end
  end

  describe '#searches_for_model' do
    class PostsSearch < Search::Index
      model Post
      text_field :title
    end

    before { object.register_search(Post, PostsSearch) }

    specify do
      expect(object.searches_for_model(Post)).to eq([PostsSearch])
    end
  end
end
