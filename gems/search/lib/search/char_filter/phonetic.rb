module Search
  class CharFilter::Phonetic
    include Performing

    MAPPINGS = {
      'ph' => 'f',
      'qu' => 'k',
      'ё' => 'е'
    }.freeze

    perform do |tokens|
      MAPPINGS.each do |pattern, value|
        tokens.each { |token| token.term.gsub!(pattern, value) }
      end
      tokens
    end
  end
end
