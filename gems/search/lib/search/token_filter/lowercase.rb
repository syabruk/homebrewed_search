module Search
  class TokenFilter::Lowercase
    include Performing

    perform do |tokens|
      tokens.map do |token|
        token.term.downcase!
      end
    end
  end
end
