module Search
  class CharFilter::Phonetic
    include Performing

    MAPPINGS = {
      'ph' => 'f',
      'qu' => 'k',
      'ё' => 'е'
    }.freeze

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        MAPPINGS.each do |pattern, value|
          token.term.gsub!(pattern, value)
        end
        token
      end
    end
  end
end
