require 'bundler/setup'
require 'rubocop'
require 'rubocop/rspec/support'
require 'rubocop_g2'
require 'pry'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end