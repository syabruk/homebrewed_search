module Search
  class Index
    class Searcher::Query
      attr_reader :model, :query, :indexed_fields, :tokens_model

      def initialize(model, tokens_model, query, indexed_fields, highlight: false)
        @model = model
        @query = query
        @indexed_fields = indexed_fields
        @tokens_model = tokens_model
        @highlight = highlight
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

      def model_table
        model.table_name
      end

      def tokens_table
        tokens_model.table_name
      end

      def select_closure
        sql = "#{model_table}.*, COUNT(#{model_table}.id) AS rank"
        sql += ", ARRAY_AGG(#{tokens_table}.matched_string) AS highlights" if fetch_highlights?
        sql
      end

      def join_closure
        "INNER JOIN #{tokens_table} ON #{model_table}.id = #{tokens_table}.document_id AND #{tokens_table}.document_type = '#{model.name}'"
      end

      def where_closure
        @where_closure ||= iterate_fields_with_tokens do |field, tokens|
          next if tokens.empty?
          terms = tokens_to_terms(tokens)
          "#{tokens_table}.column = '#{field}' AND #{tokens_table}.term IN (#{terms})"
        end.compact.join(' OR ')
      end

      def group_closure
        "#{model_table}.id"
      end

      def order_closure
        'rank DESC'
      end

      def iterate_fields_with_tokens
        indexed_fields.map do |field, performers|
          yield field, ApplyPerformers.new(query, performers).tokens
        end
      end

      def tokens_to_terms(tokens)
        terms = tokens.map do |t|
          term = Regexp.escape(t.term)
          "'#{term}'"
        end
        terms.join(', ')
      end

      def fetch_highlights?
        @highlight && where_closure.present?
      end
    end
  end
end
