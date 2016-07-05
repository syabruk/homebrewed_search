require 'active_record'

module Search
  class Token < ActiveRecord::Base
    self.table_name = :search_tokens

    belongs_to :document, polymorphic: true
  end
end
