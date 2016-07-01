module Search
  class TokenFilter::Stopword
    include Performing

    STOPWORDS = %w(a and the an or).freeze

    perform do |tokens|
      tokens.reject do |token|
        STOPWORDS.include?(token.term)
      end
    end
  end
end
