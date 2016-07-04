RSpec::Matchers.define :match_tokens do |values|
  match do |target|
    @terms = target.map(&:term).sort
    target.map(&:term).sort == values.sort
  end

  description do
    "match given terms #{values.sort}"
  end

  failure_message do
    "expected tokenized terms (#{@terms}) to #{description}"
  end

  failure_message_when_negated do
    "expected tokenized terms (#{@terms}) not to #{description}"
  end
end
