require 'lingua/stemmer'

module Search
  class TokenFilter::Stemmer
    include Performing

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token.term = Lingua.stemmer(token.term)
        token
      end
    end
  end
end
