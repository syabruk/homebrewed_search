require 'singleton'

module Search
  class Repository
    include Singleton

    attr_reader :searches

    def self.delegated
      public_instance_methods - self.superclass.public_instance_methods - Singleton.public_instance_methods
    end

    def initialize
      @searches = Hash.new { |h, k| h[k] = [] }
    end

    def register_search(model, search)
      @searches[model] << search
    end

    def searches_for_model(model)
      @searches[model]
    end
  end
end
