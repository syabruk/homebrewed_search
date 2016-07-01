module Search
  class Index
    module Searcher
      extend ActiveSupport::Concern

      module ClassMethods
        def search(query)
          Query.new(searchable_model, Search::Token, query, indexed_fields).execute
        end
      end
    end
  end
end
