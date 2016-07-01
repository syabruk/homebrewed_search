require 'ngram'

module Search
  class Tokenizer::Ngram < Tokenizer::Base
    DEFAULTS = {
      size: 3,
      word_separator: " ",
      padchar: ""
    }.freeze

    perform do |subject, options = {}|
      ngram = NGram.new(DEFAULTS.merge(options))
      Array(subject).map { |v| ngram.parse(v) }.flatten
    end
  end
end
