module Search
  class TokenFilter::Lowercase
    include Performing

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token.term.downcase!
        token
      end
    end
  end
end
