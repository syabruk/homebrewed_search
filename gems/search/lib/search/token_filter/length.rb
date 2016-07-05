module Search
  class TokenFilter::Length
    include Performing

    perform do |string_or_tokens, params|
      min = params[:min] || -Float::INFINITY
      max = params[:max] || Float::INFINITY
      range = min..max

      flat_map_tokens(string_or_tokens) do |token|
        token if range.include?(token.term.length)
      end
    end
  end
end
