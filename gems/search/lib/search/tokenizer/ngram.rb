require 'ngram'

module Search
  class Tokenizer::Ngram
    include Performing

    DEFAULTS = {
      size: 3,
      word_separator: " ",
      padchar: ""
    }.freeze

    perform do |string_or_tokens, options|
      ngram = NGram.new(DEFAULTS.merge(options))
      flat_map_tokens(string_or_tokens) do |token|
        ngram.parse(token.term).flat_map do |new_terms|
          Array(new_terms).map do |new_term|
            Token.new(term: new_term, matched_string: token.matched_string)
          end
        end
      end
    end
  end
end
