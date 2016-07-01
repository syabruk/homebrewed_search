module Search
  class Index
    include Dsl
    include Transaction
    include Indexer
    include Searcher
  end
end
