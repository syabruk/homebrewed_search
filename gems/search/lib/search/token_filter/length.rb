module Search
  class TokenFilter::Length
    include Performing

    perform do |tokens, min: nil, max: nil|
      min ||= -Float::INFINITY
      max ||= Float::INFINITY
      range = min..max

      tokens.select do |token|
        range.include?(token.term.length)
      end
    end
  end
end
