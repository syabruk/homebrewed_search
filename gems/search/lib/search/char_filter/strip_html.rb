require 'action_view'

module Search
  class CharFilter::StripHtml
    include Performing

    perform do |string_or_tokens|
      flat_map_tokens(string_or_tokens) do |token|
        token.term = ActionView::Base.full_sanitizer.sanitize(token.term)
        token
      end
    end
  end
end
