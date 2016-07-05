RSpec.describe Search::Token do
  class PostsSearch < Search::Index
    model Post
    text_field :title
  end

  describe 'association' do
    it { is_expected.to belong_to(:document) }
  end

  describe '.table_name' do
    subject { described_class }
    its(:table_name) { is_expected.to eq('search_tokens') }
  end
end
