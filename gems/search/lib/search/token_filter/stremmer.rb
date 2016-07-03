require 'lingua/stemmer'

module Search
  class TokenFilter::Stremmer
    include Performing

    perform do |tokens|
      tokens.each do |token|
        token.term = Lingua.stemmer(token.term)
      end
    end
  end
end
