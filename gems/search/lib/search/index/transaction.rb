require 'active_record/transactions'

module Search
  class Index
    module Transaction
      extend ActiveSupport::Concern

      module ClassMethods
        def transaction
          ActiveRecord::Base.transaction { yield }
        end
      end
    end
  end
end
