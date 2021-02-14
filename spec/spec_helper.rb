require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter '/spec/'
end

require_relative File.expand_path('../src/loader', File.dirname(__FILE__))
I18n.load_path << "#{File.expand_path('./config/locales')}/locale.yml"
I18n.default_locale = :en

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
