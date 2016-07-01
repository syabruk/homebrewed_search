module Search
  class Tokenizer::Standard < Tokenizer::Base
    PATTERNS = [
      /[[:space:]]/,
      /[[:punct:]]/
    ].freeze

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token.term.split(regexp).map do |new_term|
          Token.new(term: new_term, matched_string: new_term)
        end
      end
    end

    private

    def self.regexp
      @regexp ||= Regexp.union(PATTERNS)
    end
  end
end
