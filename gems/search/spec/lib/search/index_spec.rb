RSpec.describe Search::Index do
  let(:search_class) do
    Class.new(described_class) do
      model Post
      text_field :title
    end
  end

  subject { search_class }

  describe 'assigns model' do
    its(:searchable_model) { is_expected.to eq(Post) }
  end

  describe 'adds fields to index' do
    context 'without specified performers' do
      its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]] }) }
    end

    context 'with specified tokenizer' do
      context 'standard' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, tokenizer: :standard
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Standard, {}]] }) }
      end

      context 'ngram' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, tokenizer: :ngram
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Ngram, {}]] }) }
      end

      context 'specified several tokenizers' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, tokenizer: [:standard, :ngram]
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Standard, {}], [Search::Tokenizer::Ngram, {}]] }) }
      end
    end

    context 'with specified char_filter' do
      context 'phonetic' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, char_filter: :phonetic
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], char_filter: [[Search::CharFilter::Phonetic, {}]] }) }
      end

      context 'strip_html' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, char_filter: :strip_html
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], char_filter: [[Search::CharFilter::StripHtml, {}]] }) }
      end
    end

    context 'with specified token_filter' do
      context 'lowercase' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, token_filter: :lowercase
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], token_filter: [[Search::TokenFilter::Lowercase, {}]] }) }
      end

      context 'length' do
        context 'without parameters' do
          let(:search_class) do
            Class.new(described_class) do
              model Post
              text_field :title, token_filter: :length
            end
          end

          its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], token_filter: [[Search::TokenFilter::Length, {}]] }) }
        end

        context 'with parameters' do
          let(:search_class) do
            Class.new(described_class) do
              model Post
              text_field :title, token_filter: [{ length: { min: 2, max: 3 } }]
            end
          end

          its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], token_filter: [[Search::TokenFilter::Length, { min: 2, max: 3 }]] }) }
        end
      end

      context 'stopword' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, token_filter: :stopword
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], token_filter: [[Search::TokenFilter::Stopword, {}]] }) }
      end

      context 'stremmer' do
        let(:search_class) do
          Class.new(described_class) do
            model Post
            text_field :title, token_filter: :stremmer
          end
        end

        its(:indexed_fields) { is_expected.to eq(title: { tokenizer: [[Search::Tokenizer::Plain, {}]], token_filter: [[Search::TokenFilter::Stremmer, {}]] }) }
      end
    end
  end

  describe '.index!' do
    let(:search_class) do
      Class.new(described_class) do
        model Post
        text_field :title
      end
    end

    let!(:record1) { Search.without_indexing { Post.create(title: 'cars') } }
    let!(:record2) { Search.without_indexing { Post.create(title: 'maps') } }

    context 'without specified record' do
      subject { search_class.index! }

      specify do
        expect { subject }.to index(record1, record2)
      end
    end

    context 'with specified record' do
      subject { search_class.index!(record1) }

      specify do
        expect { subject }.to index(record1)
        expect { subject }.not_to index(record2)
      end
    end
  end

  describe '.delete!' do
    let(:search_class) do
      Class.new(described_class) do
        model Post
        text_field :title
      end
    end

    let!(:record1) { Post.create(title: 'cars') }
    let!(:record2) { Post.create(title: 'maps') }

    context 'without specified record' do
      subject { search_class.delete! }

      specify do
        expect { subject }.to delete_from_index(record1, record2)
      end
    end

    context 'with specified record' do
      subject { search_class.delete!(record1) }

      specify do
        expect { subject }.to delete_from_index(record1)
        expect { subject }.not_to delete_from_index(record2)
      end
    end
  end

  describe '.search' do
    let(:search_class) do
      Class.new(described_class) do
        model Post
        text_field :title
      end
    end

    let!(:record1) { Post.create(title: 'cars') }
    let!(:record2) { Post.create(title: 'maps') }

    subject { search_class.search('maps') }

    specify do
      expect(subject).to contain_exactly(record2)
      expect(subject.any? { |r| r.respond_to?(:highlights) }).to eq(false)
    end

    context 'with passed highlight argument' do
      subject { search_class.search('maps', highlight: true) }

      specify do
        expect(subject).to contain_exactly(record2)
        expect(subject.all? { |r| r.respond_to?(:highlights) }).to eq(true)
      end
    end
  end

  describe 'applies search callbacks' do
    let!(:search_class) do
      Class.new(described_class) do
        model Post
        text_field :title
      end
    end

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
