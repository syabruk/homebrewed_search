module Search
  class Index
    class Dsl::Fields::OptionsParser
      DEFAULT_OPTIONS = {
        tokenizer: :plain
      }.freeze

      attr_reader :field_options

      def initialize(field_options)
        @field_options = field_options.reverse_merge(DEFAULT_OPTIONS)
      end

      def parse
        field_options.each_with_object({}) do |(extension, performers), acc|
          extension_module = Search.const_get(extension.to_s.classify)
          acc[extension] = Array(performers).map do |performer|
            performer_name, params = Array(performer).first
            [extension_module.const_get(performer_name.to_s.classify), params || {}]
          end
        end
      end
    end
  end
end
