require 'action_view/base'

module Search
  class CharFilter::StripHtml
    include Performing

    perform do |tokens|
      tokens.each do |token|
        token.term = ActionView::Base.full_sanitizer.sanitize(token.term)
      end
    end
  end
end
