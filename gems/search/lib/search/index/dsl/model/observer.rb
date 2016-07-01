module Search
  class Index
    module Dsl::Model::Observer
      extend ActiveSupport::Concern

      included do
        after_save { Search.index!(self) }
        after_destroy { Search.delete!(self) }
      end
    end
  end
end
