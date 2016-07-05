RSpec.describe PostsController do
  describe 'GET #index' do
    let!(:post1) { Post.create!(title: 'carpets') }
    let!(:post2) { Post.create!(title: 'maps') }

    context 'format=html' do
      subject { get :index }

      it { is_expected.to be_success }
    end

    context 'format=json' do
      context 'query is not passed' do
        subject { get :index, params: { format: :json } }

        it { is_expected.to be_success }
        it { expect(json.count).to eq(2) }

        it 'returns posts' do
          expect(json).to include(title: 'carpets', body: nil, highlights: nil)
          expect(json).to include(title: 'maps', body: nil, highlights: nil)
        end
      end

      context 'query is passed' do
        subject { get :index, params: { query: 'maps', format: :json } }

        it { is_expected.to be_success }
        it { expect(json.count).to eq(1) }

        it 'returns only matched posts' do
          expect(json).not_to include(title: 'carpets', body: nil, highlights: nil)
          expect(json).to include(title: 'maps', body: nil, highlights: ['maps'])
        end
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { post: { title: 'carpet', body: 'car' } } }

    it { is_expected.to be_success }

    describe 'creates new post with given params' do
      it 'creates post' do
        expect { subject }.to change(Post, :count).by(1)
      end

      context 'has correct attributes' do
        before { subject }

        let(:new_post) { Post.last }

        it { expect(new_post.title).to eq('carpet') }
        it { expect(new_post.body).to eq('car') }
      end
    end

    it 'adds new post to index' do
      expect { subject }.to index
    end

    it 'returns created post' do
      expect(json).not_to eq(title: 'carpet', body: 'car', highlights: nil)
    end
  end
end
