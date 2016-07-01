module Search
  class Index
    class Searcher::Query
      attr_reader :model, :query, :indexed_fields, :tokens_model

      def initialize(model, tokens_model, query, indexed_fields)
        @model = model
        @query = query
        @indexed_fields = indexed_fields
        @tokens_model = tokens_model
      end

      def execute
        model
          .select(select_closure)
          .joins(join_closure)
          .where(where_closure)
          .group(group_closure)
          .order(order_closure)
      end

      private

      def tokens_table
        tokens_model.table_name
      end

      def select_closure
        "#{model.table_name}.*, COUNT(#{model.table_name}.id) AS rank"
      end

      def join_closure
        "INNER JOIN #{tokens_table} ON #{model.table_name}.id = #{tokens_table}.document_id AND #{tokens_table}.document_type = '#{model.name}'"
      end

      def where_closure
        iterate_fields_with_tokens do |field, tokens|
          next if tokens.empty?
          terms = tokens.map { |t| "'#{t.term}'" }.join(", ")
          "#{tokens_table}.column = '#{field}' AND #{tokens_table}.term IN (#{terms})"
        end.compact.join(' OR ')
      end

      def group_closure
        "#{model.table_name}.id"
      end

      def order_closure
        "rank DESC"
      end

      def iterate_fields_with_tokens
        indexed_fields.map do |field, performers|
          yield field, ApplyPerformers.new(query, performers).tokens
        end
      end
    end
  end
end
