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

      def execute_perform(*args)
        instance_exec(*args, &_perform_proc)
      end
    end
  end
end
