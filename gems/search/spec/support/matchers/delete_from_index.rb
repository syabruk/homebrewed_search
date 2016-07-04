RSpec::Matchers.define :delete_from_index do |record|
  match do |block|
    @tokens_before_call = Search::Token.where(document: record).to_a
    block.call
    @tokens_before_call.any? && !Search::Token.where(document: record).exists?
  end

  description do
    message = "delte record #{record.inspect} from index"
    if @tokens_before_call.blank?
      message += " but there were no tokens in index"
    end
    message
  end

  failure_message do
    "expected to #{description}"
  end

  failure_message_when_negated do
    "expected not to #{description}"
  end

  supports_block_expectations
end
