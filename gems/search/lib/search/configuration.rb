require 'singleton'

module Search
  class Configuration
    include Singleton

    attr_reader :config

    def self.delegated
      public_instance_methods - self.superclass.public_instance_methods - Singleton.public_instance_methods
    end

    def initialize
      @config = Hash.new { |h, k| h[k] = [] }
    end

    def enabled?
      @config.fetch(:enabled, true)
    end

    def enable_indexing!
      @config[:enabled] = true
    end

    def disable_indexing!
      @config[:enabled] = false
    end
  end
end
