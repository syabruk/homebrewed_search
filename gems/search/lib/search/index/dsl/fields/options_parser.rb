module Search
  class Index
    module Dsl::Fields::OptionsParser
      def self.parse(options)
        options.inject(Hash.new) do |acc, (extension, performers)|
          extension_module = Search.const_get(extension.to_s.classify)
          acc[extension] = Array(performers).map do |performer|
            performer_name, params = Array(performer).first
            [extension_module.const_get(performer_name.to_s.classify), params || {}]
          end
          acc
        end
      end
    end
  end
end
