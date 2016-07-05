RSpec::Matchers.define :match_tokens do |values|
  match do |target|
    @terms = target.map { |t| { t.term => t.matched_string } }.reduce(&:merge) || {}

    values.stringify_keys!.transform_values!(&:to_s)

    @difference = calculate_difference(values, @terms)
    @difference.blank?
  end

  description do
    "match given terms #{values}"
  end

  failure_message do
    "expected tokenized terms (#{@terms}) to #{description}, but diffenence is #{@difference}"
  end

  failure_message_when_negated do
    "expected tokenized terms (#{@terms}) not to #{description}"
  end

  private

  def calculate_difference(hash1, hash2)
    if hash1.size > hash2.size
      difference = hash1.to_a - hash2.to_a
    else
      difference = hash2.to_a - hash1.to_a
    end

    Hash[*difference.flatten]
  end
end
