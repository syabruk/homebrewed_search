module Search
  class Index
    module Dsl::Fields
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Model

        class_attribute :_fields
        self._fields = {}
      end

      module ClassMethods
        def text_field(field, options={})
          self._fields[field] = OptionsParser.parse(options)
        end

        def indexed_fields
          self._fields
        end
      end
    end
  end
end
