require 'activerecord-import'

module Search
  class Index
    module Indexer
      extend ActiveSupport::Concern

      module ClassMethods
        def index!(record_or_ids = nil)
          return unless Search.enabled?

          scope = scope_for_index(record_or_ids)
          transaction do
            purge_tokens(scope)
            iterate_scope(scope) do |record|
              index_record(record, indexed_fields)
            end
          end
        end

        def delete!(record_or_ids = nil)
          return unless Search.enabled?

          scope = scope_for_index(record_or_ids)
          transaction { purge_tokens(scope) }
        end

        private

        def iterate_scope(scope)
          method = scope.respond_to?(:find_each) ? :find_each : :each

          scope.public_send(method) { |record| yield record }
        end

        def scope_for_index(record_or_ids)
          case record_or_ids
          when ActiveRecord::Base
            Array(record_or_ids)
          when Integer, Array
            searchable_model.where(id: ids)
          else
            searchable_model.all
          end
        end

        def index_record(record, fields)
          tokens = []
          fields.each do |field, performers|
            tokens_for_field(record, field, performers).map do |token|
              token.assign_attributes(document: record, column: field)
              tokens << token
            end
          end
          Token.import tokens
        end

        def purge_tokens(model_scope)
          Token.where(document: model_scope).delete_all
        end

        def tokens_for_field(record, field, performers)
          value = record.public_send(field)
          ApplyPerformers.new(value, performers).tokens
        end
      end
    end
  end
end
