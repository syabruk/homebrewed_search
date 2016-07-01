module Search
  class Index
    class ApplyPerformers
      PERFORMING_ORDER = %i[tokenizer char_filter token_filter].freeze

      def initialize(value, performers)
        @value = value && value.dup
        @performers = performers
      end

      def tokens
        return [] unless @value

        performers.values_at(*PERFORMING_ORDER).compact.each do |extensions|
          extensions.each do |performer, params|
            @value = performer.execute_perform(@value, params)
          end
        end

        @value
      end

      private

      attr_reader :performers
    end
  end
end
