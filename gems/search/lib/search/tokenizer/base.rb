module Search
  class Tokenizer::Base
    include Performing

    def self.flat_map_tokens(string_or_tokens)
      Array(string_or_tokens).flat_map do |string_or_token|
        return [] if string_or_token.blank?
        token = if string_or_token.is_a?(String)
          Token.new(term: string_or_token, matched_string: string_or_token)
        else
          string_or_token
        end
        yield token
      end
    end
  end
end
