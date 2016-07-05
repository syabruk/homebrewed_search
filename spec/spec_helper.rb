require 'database_cleaner'
require 'shoulda-matchers'
require 'rspec/its'
require 'search/rspec'
require 'rspec/rails'

I18n.enforce_available_locales = true

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.render_views = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.infer_spec_type_from_file_location!
end

Dir[File.join(Dir.pwd, 'spec/support/**/*.rb')].sort.each { |f| require f }
