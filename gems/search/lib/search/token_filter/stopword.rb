module Search
  class TokenFilter::Stopword
    include Performing

    STOPWORDS = %w(a and the an or).freeze

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token if STOPWORDS.exclude?(token.term)
      end
    end
  end
end
