module Search
  module Performing
    extend ActiveSupport::Concern

    included do
      class_attribute :_perform_proc
    end

    module ClassMethods
      def perform(&block)
        self._perform_proc = block
      end

      def execute_perform(args, params)
        response = if _perform_proc.arity == 1
          instance_exec(args, &_perform_proc)
        else
          instance_exec(args, params, &_perform_proc)
        end

        Array(response).select(&:present?)
      end

      def flat_map_tokens(string_or_tokens)
        Array(string_or_tokens).flat_map do |string_or_token|
          next if string_or_token.blank?
          token = if string_or_token.is_a?(String)
            Token.new(term: string_or_token, matched_string: string_or_token)
          else
            string_or_token
          end
          yield token
        end
      end
    end
  end
end
