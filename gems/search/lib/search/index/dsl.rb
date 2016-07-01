module Search
  class Index
    module Dsl
      extend ActiveSupport::Concern

      include Fields
      include Model
    end
  end
end
