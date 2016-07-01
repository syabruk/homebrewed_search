module Search
  class Index
    module Dsl::Model
      extend ActiveSupport::Concern

      included do
        class_attribute :_model
      end

      module ClassMethods
        def model(klass)
          self._model = klass
          klass.include Observer
          Search.register_search(klass, self)
        end

        def searchable_model
          self._model
        end
      end
    end
  end
end
