module Search
  class Index
    module Searcher
      extend ActiveSupport::Concern

      autoload :Query, 'search/index/searcher/query'

      module ClassMethods
        def search(query, highlight: false)
          Query.new(searchable_model, Search::Token, query, indexed_fields, highlight: highlight).execute
        end
      end
    end
  end
end
