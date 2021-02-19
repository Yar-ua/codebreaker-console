require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter '/spec/'
end

require_relative File.expand_path('../src/loader', File.dirname(__FILE__))
require_relative './support/constants'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.syntax = %i[expect should]
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
