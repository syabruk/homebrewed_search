require 'active_record'
require 'database_cleaner'
require 'rails'
require 'shoulda-matchers'
require 'rspec/its'

require 'search'

I18n.enforce_available_locales = true

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expose_dsl_globally = false

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

Dir[File.join(Dir.pwd, 'spec/support/**/*.rb')].sort.each { |f| require f }
