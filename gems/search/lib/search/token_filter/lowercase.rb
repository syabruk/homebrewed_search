module Search
  class TokenFilter::Lowercase
    include Performing

    perform do |tokens|
      tokens.each do |token|
        token.term.downcase!
      end
    end
  end
end
