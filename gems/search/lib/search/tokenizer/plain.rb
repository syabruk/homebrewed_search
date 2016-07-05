module Search
  class Tokenizer::Plain
    include Performing

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token
      end
    end
  end
end
