RSpec::Matchers.define :index do |record|
  match do |block|
    block.call

    if record
      Search::Token.where(document: record).exists?
    else
      Search::Token.all.exists?
    end
  end

  description do
    if record
      "index record #{record.inspect}"
    else
      "index any records"
    end
  end

  failure_message do
    "expected to #{description}"
  end

  failure_message_when_negated do
    "expected not to #{description}"
  end

  supports_block_expectations
end
